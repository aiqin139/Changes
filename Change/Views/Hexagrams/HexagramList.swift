//
//  HexagramList.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramNavigationView: View {
    @EnvironmentObject var modelData: ModelData
    
    var allHexagrams: [Hexagram] {
        modelData.basicHexagrams + modelData.derivedHexagrams
    }
    
    var filteredHexagrams: [Hexagram] {
        allHexagrams.filter {
            ($0.name.hasPrefix(modelData.searchBarText) || modelData.searchBarText.isEmpty)
        }
    }
    
    var body: some View {
        Form {
            if modelData.searchBarText.isEmpty {
                Section(header: Text("   基本八卦").font(.title2)) {
                    ForEach(modelData.basicHexagrams, id: \.self) { hexagram in
                        NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                            HexagramRow(hexagram: hexagram)
                        }
                    }
                }
                
                Section(header: Text("   六十四卦").font(.title2)) {
                    ForEach(modelData.derivedHexagrams, id: \.self) { hexagram in
                        NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                            HexagramRow(hexagram: hexagram)
                        }
                    }
                }
            } else {
                ForEach(filteredHexagrams, id: \.self) { hexagram in
                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                        HexagramRow(hexagram: hexagram)
                    }
                }
            }
        }
        .navigationTitle("卦象")
    }
}

struct HexagramList: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView() {
            HexagramNavigationView()
                .environmentObject(modelData)
        }
    }
}

struct HexagramList_Previews: PreviewProvider {
    static var previews: some View {
        HexagramList()
            .environmentObject(ModelData())
    }
}
