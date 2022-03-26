//
//  ContentView.swift
//  citysight app
//
//  Created by Sam Tech on 3/22/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        //Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined{
            // if undertermined, show onboarding
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse{
            // if approved, show home view
            HomeView()
            BusinessListView()
        }
        else{
            // if denied show devied view
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
