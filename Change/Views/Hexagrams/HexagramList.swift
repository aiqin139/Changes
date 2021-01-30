//
//  HexagramList.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramList: View {
    @State private var selection: Tab = .basic
    
    enum Tab {
        case basic
        case derived
    }
    
    var selectedHexagrams: [Hexagram] {
        if selection == Tab.basic {
            return basicHexagrams
        }
        else if selection == Tab.derived {
            return derivedHexagrams
        }
        return [Hexagram]()
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
                Picker("卦象", selection: $selection) {
                    Text("基本八卦").tag(Tab.basic)
                    Text("六十四卦").tag(Tab.derived)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                ForEach(selectedHexagrams, id: \.self) { hexagram in
                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                        HexagramRow(hexagram: hexagram)
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
    }
}
