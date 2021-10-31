//
//  CategoryMatrix.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct HexagramMatrixNavigationView: View {
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
        ScrollView(.vertical) {
            if modelData.searchBarText.isEmpty {
                Section(header: Text("基本八卦").font(.title2)) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0...3, id: \.self) { vindex in
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(0...1, id: \.self) { hindex in
                                    let hexagram: Hexagram = modelData.basicHexagrams[vindex * 2 + hindex]
                                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                                        CategoryItem(hexagram: hexagram)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("六十四卦").font(.title2)) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0...31, id: \.self) { vindex in
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(0...1, id: \.self) { hindex in
                                    let hexagram: Hexagram = modelData.derivedHexagrams[vindex * 2 + hindex]
                                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                                        CategoryItem(hexagram: hexagram)
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                ForEach(filteredHexagrams, id: \.self) { hexagram in
                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                        CategoryItem(hexagram: hexagram)
                    }
                }
            }
        }
        .navigationTitle("卦象")
    }
}

struct HexagramMatrix: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView() {
            HexagramMatrixNavigationView()
                .environmentObject(modelData)
        }
    }
}

struct HexagramMatrix_Previews: PreviewProvider {
    static var previews: some View {
        HexagramMatrix()
            .environmentObject(ModelData())
    }
}
