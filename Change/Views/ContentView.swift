//
//  ContentView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .prediction
    
    enum Tab {
        case prediction
        case explanation
        case summary
        case hexagram
    }
    
    var body: some View {
        TabView(selection: $selection) {
            PredictionView()
                .tabItem {
                    Label("占卦", systemImage: "star")
                }
                .tag(Tab.prediction)

            
            ExplanationView()
                .tabItem {
                    Label("解卦", systemImage: "safari")
                }
                .tag(Tab.explanation)
            
            /*CategoryMatrix()
                .tabItem {
                    Label("概览", systemImage: "xserve")
                }
                .tag(Tab.summary)*/
            
            HexagramList()
                .tabItem {
                    Label("卦象", systemImage: "bonjour")
                }
                .tag(Tab.hexagram)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
