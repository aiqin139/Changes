//
//  HexagramList.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramList: View {
    @State private var selection: Tab = .basiclist
    
    enum Tab {
        case basiclist
        case derivedlist
    }
    
    var selectedHexagrams: [Hexagram] {
        if selection == Tab.basiclist {
            return basicHexagrams
        }
        else if selection == Tab.derivedlist {
            return derivedHexagrams
        }
        return [Hexagram]()
    }
    
    var selectedTitle: String {
        if selection == Tab.basiclist {
            return "基本八卦"
        }
        else if selection == Tab.derivedlist {
            return "六十四卦"
        }
        return String()
    }
    
    var body: some View {
        NavigationView() {
            List {
                Picker("卦象", selection: $selection) {
                    Text("基本八卦").tag(Tab.basiclist)
                    Text("六十四卦").tag(Tab.derivedlist)
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
