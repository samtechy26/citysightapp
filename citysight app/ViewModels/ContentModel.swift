//
//  ContentModel.swift
//  citysight app
//
//  Created by Sam Tech on 3/22/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject{
    var locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init(){
        //init method of NSObject
        super.init()
        //set content model as the delegate of the location manager
        locationManager.delegate = self
        //Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        //Start geolocating the user:after getting permission
        //locationManager.stopUpdatingLocation()
    }
    
    //MARK: Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse{
            //we have permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied{
            // we don't have permisson
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            //we have a location
            
            //stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            //if we have the users cordinates we send it to the yelp api
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantKey, location: userLocation!)
        }
        
       
    }
    
    func getBusinesses(category:String, location:CLLocation){
        //create URL
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
        //create URL Request
        if url != nil {
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            //get url session
            let session = URLSession.shared
            //get datatask
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil{
                    
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            //assign results to the appropriate property
                            
                            switch category{
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                            
                        }
                        
                    }
                    catch{
                        print(error)
                    }
                }
            }
            //lunch datatask
            dataTask.resume()
        }
        
        
        
        
        
        
        
    }
}
