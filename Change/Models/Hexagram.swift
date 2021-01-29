//
//  BaseHexagram.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation
import SwiftUI

struct Hexagram: Hashable, Codable {
    var id: Int
    var name: String
    var pinyin: String
    var image: Image { Image(name) }
    var explanations: [[String]]
}
