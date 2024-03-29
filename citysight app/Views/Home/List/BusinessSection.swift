//
//  BusinessSection.swift
//  citysight app
//
//  Created by Sam Tech on 3/25/22.
//

import SwiftUI

struct BusinessSection: View {
    var title:String
    var businesses:[Business]
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)){
            ForEach(businesses){
                business in
                NavigationLink(destination: {
                    BusinessDetail(business: business)
                }, label: {
                    BusinessRow(business: business)
                })
                
            }
        }
    }
}

//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection()
//    }
//}
