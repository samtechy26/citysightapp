//
//  BusinessMap.swift
//  citysight app
//
//  Created by Sam Tech on 3/27/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable{
    @EnvironmentObject var model:ContentModel
    @Binding var selectedBusiness:Business?
    
    var locations:[MKPointAnnotation]{
        
        
        var annotations = [MKPointAnnotation]()
        
        //create a set of annotations from our list of businesses
        for business in model.restaurants + model.sights{
            
            // if the business has a lat/long
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
           
            }
             }
         return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        //Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        //TO DO: set the region
        
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        //Add the ones related to business
        //uiView.addAnnotations(self.locations)
        uiView.showAnnotations(self.locations, animated: true)
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        //
        uiView.removeAnnotations(uiView.annotations)
    }
    
    //MARK: Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    class Coordinator: NSObject, MKMapViewDelegate{
        
        var map:BusinessMap
        init(parent:BusinessMap){
            self.map = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // if the annotation is the user blue dot, return nil
            if annotation is MKUserLocation{
                return nil
            }
            //check if there is a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReusedId)
            if annotationView == nil{
                //create a new one
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReusedId)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else{
                annotationView!.annotation = annotation
            }
            
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            //user tapped on the annotation
            
            //get the business object that the annotation represents
            //loop through businesses in the model
            for business in map.model.restaurants + map.model.sights{
                if business.name == view.annotation?.title{
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
