//
//  citysight_appApp.swift
//  citysight app
//
//  Created by Sam Tech on 3/22/22.
//

import SwiftUI

@main
struct citysight_appApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
