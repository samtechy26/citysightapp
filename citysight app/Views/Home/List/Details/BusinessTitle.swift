//
//  Business Title.swift
//  citysight app
//
//  Created by Sam Tech on 3/31/22.
//

import SwiftUI

struct BusinessTitle: View {
    var business:Business
    
    var body: some View {
        VStack(alignment: .leading){
            //Business name
            Text(business.name!)
                .multilineTextAlignment(.leading)
                .font(.largeTitle)
                
            //Address
            if business.location?.displayAddress != nil{
                ForEach(business.location!.displayAddress!, id:\.self){
                    displayLine in
                    Text(displayLine)
                        
                    
                }
            }
            
            //Rating
            Image("regular_\(business.rating ?? 0)")
                
        }
        .foregroundColor(.black)
        
    }
}


