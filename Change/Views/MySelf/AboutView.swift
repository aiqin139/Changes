//
//  AboutView.swift
//  Change
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            Text("本软件由aicodeone开发，版权所有！")
        }
        .navigationTitle("关于")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
