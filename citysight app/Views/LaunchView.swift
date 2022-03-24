//
//  ContentView.swift
//  citysight app
//
//  Created by Sam Tech on 3/22/22.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
