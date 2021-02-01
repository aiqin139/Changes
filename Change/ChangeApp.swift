//
//  ChangeApp.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

@main
struct ChangeApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
