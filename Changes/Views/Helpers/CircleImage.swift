//
//  CircleImage.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct CircleImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
            .frame(width: 200, height: 200)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: "乾")
    }
}
