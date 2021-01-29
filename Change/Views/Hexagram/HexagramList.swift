//
//  HexagramList.swift
//  Change
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

struct HexagramList: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(hexagrams, id: \.self) { hexagram in
                    NavigationLink(destination: HexagramDetail(hexagram: hexagram)) {
                        HexagramRow(hexagram: hexagram)
                    }
                }
            }
            .navigationTitle("易经六十四卦")
        }
    }
}

struct HexagramList_Previews: PreviewProvider {
    static var previews: some View {
        HexagramList()
    }
}
