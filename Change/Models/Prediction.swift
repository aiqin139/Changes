//
//  Prediction.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation

struct Prediction {
    var hexagram: Hexagram = Hexagram()
    var explanation: [String] = [""]
    
    mutating func DigitPrediction(hexagrams: [Hexagram], value1: Int, value2: Int, value3: Int) {
        let part1 = (value1 % 8) != 0 ? (value1 % 8) : 8
        let part2 = (value2 % 8) != 0 ? (value2 % 8) : 8
        let index = (value3 % 6) != 0 ? (value3 % 6) : 6
        
        self.hexagram = hexagrams.filter { $0.id == (8 * (part1 - 1)) + part2 }[0]
        self.explanation = hexagram.explanations[index]
    }
}
