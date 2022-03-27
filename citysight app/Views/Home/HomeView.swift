//
//  HomeView.swift
//  citysight app
//
//  Created by Sam Tech on 3/25/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0{
            NavigationView{
                if isMapShowing == false {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "location")
                            Text("San Fransisco")
                            Spacer()
                            Button("Switch to Map View") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessListView()
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }
                else{
                    //Show Map
                    BusinessMap()
                        .ignoresSafeArea()
                }
            }
            
        }
        else{
            // still waiting for api response, show spining
            ProgressView()
            Text("Still fetching")
        }
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
