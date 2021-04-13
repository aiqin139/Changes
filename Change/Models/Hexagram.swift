//
//  BaseHexagram.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation
import SwiftUI

struct Hexagram: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var pinyin: String
    var description: String
    var explanations: [[String]]
    
    init()
    {
        id = 0
        name = ""
        pinyin = ""
        description = ""
        explanations = [[""]]
    }
}
