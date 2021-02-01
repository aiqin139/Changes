//
//  Prediction.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation

struct DigitalPrediction {
    var hexagram: Hexagram = Hexagram()
    var explanation: [String] = [""]
    
    mutating func Execute(hexagrams: [Hexagram], value1: Int, value2: Int, value3: Int) {
        let part1 = (value1 % 8) != 0 ? (value1 % 8) : 8
        let part2 = (value2 % 8) != 0 ? (value2 % 8) : 8
        let index = (value3 % 6) != 0 ? (value3 % 6) : 6
        
        self.hexagram = hexagrams.filter { $0.id == (8 * (part1 - 1)) + part2 }[0]
        self.explanation = hexagram.explanations[index]
    }
}


struct DayanPrediction {
    var benHexagram: Hexagram = Hexagram()
    var zhiHexagram: Hexagram = Hexagram()
    var explanation1: [String] = [""]
    var explanation2: [String] = [""]
    
    private func BaseCalculate(d: Int, s: Int) ->Int {
        let a = s
        let b = d - a
        let c = 1 + (((a - 1) % 4) != 0 ? ((a - 1) % 4) : 4) + ((b % 4) != 0 ? (b % 4) : 4)
        return d - c
    }
    
    mutating func Execute(hexagrams: [Hexagram]) {
        //six step result
        var r: [Int] = [0, 0, 0, 0, 0, 0]
        
        //six step
        for i in 0..<6 {
            var d = 50 - 1
            
            //three step
            for _ in 0..<3 {
                d = BaseCalculate(d: d, s: Int(arc4random()) % d)
            }
            
            //store result
            r[i] = d / 4
        }
        
        //calculate ben and zhi hexagram part1 and part2
        var benPart1 = 0
        var benPart2 = 0
        var zhiPart1 = 0
        var zhiPart2 = 0
        for i in 0..<3 {
            benPart1 |= (((r[i] == 6) || (r[i] == 8)) ? 1 : 0) << (2 - i)
            zhiPart1 |= (((r[i] == 9) || (r[i] == 8)) ? 1 : 0) << (2 - i)
            benPart2 |= (((r[i + 3] == 6) || (r[i + 3] == 8)) ? 1 : 0) << (2 - i)
            zhiPart2 |= (((r[i + 3] == 9) || (r[i + 3] == 8)) ? 1 : 0) << (2 - i)
        }
        
        //gets the ben hexagram and zhi hexagram
        self.benHexagram = hexagrams.filter { $0.id == (8 * benPart1) + (benPart2 + 1) }[0]
        self.zhiHexagram = hexagrams.filter { $0.id == (8 * zhiPart1) + (zhiPart2 + 1) }[0]
        
        //calculate the number of change
        var change = 0
        for i in 0..<6 {
            if r[i] == 9 || r[i] == 6 {
                change += 1
            }
        }
        
        //gets the explanations
        if change == 0 {
            explanation1 = benHexagram.explanations[0]
            explanation2 = [""]
        } else if change == 1 {
            for i in 0..<6 {
                if r[i] == 9 || r[i] == 6 {
                    explanation1 = benHexagram.explanations[i + i]
                }
            }
            explanation2 = [""]
        } else if change == 2 {
            for i in 0..<6 {
                if r[i] == 9 || r[i] == 6 {
                    if explanation1 == [""] {
                        explanation1 = benHexagram.explanations[i + 1]
                    } else {
                        explanation2 = benHexagram.explanations[i + 1]
                    }
                }
            }
        } else if change == 3 {
            explanation1 = benHexagram.explanations[0]
            explanation2 = zhiHexagram.explanations[0]
        } else if change == 4 {
            for i in 0..<6 {
                if r[i] == 7 || r[i] == 8 {
                    if explanation2 == [""] {
                        explanation2 = zhiHexagram.explanations[i + i]
                    } else {
                        explanation1 = zhiHexagram.explanations[i + i]
                    }
                }
            }
        } else if change == 5 {
            for i in 0..<6 {
                if r[i] == 7 || r[i] == 8 {
                    explanation1 = benHexagram.explanations[i + i]
                }
            }
            explanation2 = [""]
        } else if change == 6 {
            explanation1 = zhiHexagram.explanations[0]
            explanation2 = [""]
        }
    }
}
