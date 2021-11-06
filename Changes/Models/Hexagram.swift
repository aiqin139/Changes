//
//  BaseHexagram.swift
//  Changes
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

enum Purposes: String, CaseIterable, Identifiable {
    case fortune = "时运"
    case Wealth = "财运"
    case Homestead = "家宅"
    case body = "身体"
    
    var id: String { self.rawValue }
}
