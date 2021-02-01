//
//  Prediction.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation

var val1Str: String = "0"
var val2Str: String = "0"
var val3Str: String = "0"

struct Prediction {
    var hexagrams: [Hexagram]
    
    public struct Result {
        var hexagram: Hexagram
        var explanation: [String]
    }
    
    public func DigitPrediction(value1: Int, value2: Int, value3: Int) ->Result {
        let part1 = (value1 % 8) != 0 ? (value1 % 8) : 8
        let part2 = (value2 % 8) != 0 ? (value2 % 8) : 8
        let index = (value3 % 6) != 0 ? (value3 % 6) : 6
        
        let hexagram: Hexagram = hexagrams.filter { $0.id == (8 * (part1 - 1)) + part2 }[0]
        
        return Result(hexagram: hexagram, explanation: hexagram.explanations[index])
    }
}
