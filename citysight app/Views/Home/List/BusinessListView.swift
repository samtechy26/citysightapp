//
//  BusinessListView.swift
//  citysight app
//
//  Created by Sam Tech on 3/25/22.
//

import SwiftUI

struct BusinessListView: View {
    
    @EnvironmentObject var model:ContentModel
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]){
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                
                BusinessSection(title: "Sights", businesses: model.sights)
                }
            .padding(.horizontal)
                
            }
        }
    }


struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
