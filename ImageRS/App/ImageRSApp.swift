//
//  ImageRSApp.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import SwiftUI

@main
struct ImageRSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImageModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
