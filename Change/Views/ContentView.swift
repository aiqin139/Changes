//
//  ContentView.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HexagramDetail(hexagram: hexagrams[0])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
