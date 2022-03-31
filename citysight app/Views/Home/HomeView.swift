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
    @State var selectedBusiness:Business?
    
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
                    
                    ZStack(alignment: .top){
                        //Show Map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                // create the business detail view
                                //pass in the selected business
                                BusinessDetail(business: business)
                            }
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                    .frame(height:48)
                            HStack{
                                Image(systemName: "location")
                                Text("San Fransisco")
                                Spacer()
                                Button("Switch to List View") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .navigationBarHidden(true)
                    
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
