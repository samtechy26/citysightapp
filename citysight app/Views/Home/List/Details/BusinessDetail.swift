//
//  BusinessDetail.swift
//  citysight app
//
//  Created by Sam Tech on 3/26/22.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business:Business
    @State private var showDirections = false
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
                GeometryReader{ geo in
                    
                    //set up the image of the business
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    
                }
                .ignoresSafeArea(.all, edges: .top)
               
                
                ZStack(alignment:.leading){
                    Rectangle()
                        .frame(height:36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed" : "Open")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            
            Group{
                BusinessTitle(business: business)
                    .padding()
                    
                Divider()
                //Phone
                HStack{
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                //Reviews
                Divider()
                HStack{
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                        
                }.padding()
                //website
                Divider()
                HStack{
                    Text("Website:")
                        .bold()
                    Text(String(business.url ?? ""))
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                        
                }.padding()
                Divider()
                
            }
            Button{
                //show directions
                showDirections = true
            }label: {
                ZStack{
                    Rectangle()
                        .frame(height:48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                    
                }
                .padding()
                .sheet(isPresented: $showDirections) {
                    DirectionsView(business: business)
                }
            }
            
        }
    }
}


