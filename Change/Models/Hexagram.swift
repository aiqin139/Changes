//
//  BaseHexagram.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation
import SwiftUI

struct Hexagram: Hashable, Codable {
    var name: String
    var explanations: [String]
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
