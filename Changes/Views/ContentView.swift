//
//  ContentView.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .prediction

    enum Tab {
        case prediction
        case hexagram
        case more
    }
    
    var body: some View {
        TabView(selection: $selection) {
            PredictionView()
                .tabItem {
                    Label("占卦", systemImage: "star")
                }
                .tag(Tab.prediction)
            
            HexagramList()
                .tabItem {
                    Label("卦象", systemImage: "bonjour")
                }
                .tag(Tab.hexagram)
            
            MoreView()
                .tabItem {
                    Label("更多", systemImage: "ellipsis.circle")
                }
                .tag(Tab.more)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
