//
//  DirectionsView.swift
//  citysight app
//
//  Created by Sam Tech on 3/31/22.
//

import SwiftUI

struct DirectionsView: View {
    
    var business:Business
    
    var body: some View {
        VStack(alignment:.leading){
            //Business title
            HStack{
                BusinessTitle(business: business)
                Spacer()
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                    Link("Open in Maps", destination: URL(string:"http://maps.apple.com/?ll=\(lat),\(long)&q=\(name)")!)
                }
                
            }
            .padding()
            //Directions Map
            DirectionsMap(business: business)
        }
    }
}


