//
//  HexagramList.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var selection: Tab = .derived
    @State private var searchText = ""

    enum Tab {
        case basic
        case derived
    }

    var selectedHexagrams: [Hexagram] {
        if selection == Tab.basic {
            return modelData.basicHexagrams
        }
        else if selection == Tab.derived {
            return modelData.derivedHexagrams
        }
        return [Hexagram]()
    }

    var filteredHexagrams: [Hexagram] {
        selectedHexagrams.filter {
            ($0.name.hasPrefix(searchText) || searchText == "")
        }
    }

    var selectedTitle: String {
        if selection == Tab.basic {
            return "基本八卦"
        }
        else if selection == Tab.derived {
            return "六十四卦"
        }
        return String()
    }

    var body: some View {
        NavigationView() {
            List {
                Section {
                    SearchBar(text: $searchText)

                    Picker("卦象", selection: $selection) {
                        Text("基本八卦").tag(Tab.basic)
                        Text("六十四卦").tag(Tab.derived)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                let row = (selection == Tab.basic) ? 0 : 7
                    
                ForEach(0...row, id: \.self) { vindex in
                    ForEach(0...7, id: \.self) { hindex in
                        let hexagram = filteredHexagrams[vindex * 8 + hindex]
                        NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                            HexagramRow(hexagram: hexagram)
                        }
                    }
                }
            }
            .navigationTitle(selectedTitle)
        }
    }
}

struct HexagramListList_Previews: PreviewProvider {
    static var previews: some View {
        HexagramList()
            .environmentObject(ModelData())
    }
}
