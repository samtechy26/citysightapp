//
//  DirectionsMap.swift
//  citysight app
//
//  Created by Sam Tech on 3/31/22.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable{
    
    @EnvironmentObject var model:ContentModel
    var business:Business
    
    var start:CLLocationCoordinate2D{
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end:CLLocationCoordinate2D{
        if let lat = business.coordinates?.latitude,
           let long = business.coordinates?.longitude{
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        else{
           return CLLocationCoordinate2D()
        }
        
    }
        
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        //create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        //create directions object
        let directions = MKDirections(request: request)
        
        //calculate route
        directions.calculate { (response, error) in
            if error == nil && response != nil {
                for route in response!.routes {
                    map.addOverlay(route.polyline)
                    
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                }
                
            }
        }
        
        //place annotation for the endpoint
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = end
        annotation.title = business.name ?? ""
        map.addAnnotation(annotation)
        return map
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        //
        uiView.removeAnnotations((uiView.annotations))
        uiView.removeOverlays(uiView.overlays)
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        
        return DirectionsMap.Coordinator()
    }

    
    
    class Coordinator: NSObject, MKMapViewDelegate{
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            render.strokeColor = .blue
            render.lineWidth = 5
            return render
        }
    }
}
