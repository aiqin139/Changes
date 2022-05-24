//
//  Prediction.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation

struct DigitalData : Hashable, Codable {
    var purpose: String = ""
    var id: Int = 0
    var type: String = ""
    var name: String = ""
    var pinyin: String = ""
    var explanation: [String] = [""]
    var result: [Int] = [0, 0, 0]
    var values: [Int] = [500, 500, 500]
    var changeYao: Int = 0
}


struct DayanData : Hashable, Codable {
    var purpose: String = ""
    var benId: Int = 0
    var zhiId: Int = 0
    var benType: String = ""
    var zhiType: String = ""
    var benName: String = ""
    var benPinyin: String = ""
    var zhiName: String = ""
    var zhiPinyin: String = ""
    var explanation1: [String] = [""]
    var explanation2: [String] = [""]
    var result: [Int] = [6, 6, 7, 8, 9, 9]
    var changeYaos: Int = 0
}


struct DigitalPrediction {
    var data: DigitalData = DigitalData()
    
    private func Random() -> Int {
        return Int(arc4random()) % 999
    }
    
    mutating func Execute() {
        data.values[0] = Random()
        data.values[1] = Random()
        data.values[2] = Random()
    }
    
    mutating func Parser(hexagrams: [Hexagram]) {
        data.result[0] = (data.values[0] % 8) != 0 ? (data.values[0] % 8) : 8
        data.result[1] = (data.values[1] % 8) != 0 ? (data.values[1] % 8) : 8
        data.result[2] = (data.values[2] % 6) != 0 ? (data.values[2] % 6) : 6
        
        let hexagram = hexagrams.filter { $0.id == (8 * (data.result[0] - 1)) + data.result[1] }[0]
        data.id = hexagram.id
        data.type = hexagram.type
        data.name = hexagram.name
        data.pinyin = hexagram.pinyin
        data.explanation = hexagram.explanations[data.result[2]]
        data.changeYao = 1 << (data.result[2] - 1)
    }
}


struct DayanPrediction {
    var data: DayanData = DayanData()
    
    private func BaseCalculate(d: Int, s: Int) ->Int {
        let a = s
        let b = d - a
        let c = 1 + (((a - 1) % 4) != 0 ? ((a - 1) % 4) : 4) + ((b % 4) != 0 ? (b % 4) : 4)
        return d - c
    }
    
    mutating func Execute() {
        //six steps
        for i in 0..<6 {
            var d = 50 - 1
            
            //three steps
            for _ in 0..<3 {
                var s = 0
                while s == 0 {
                    s = Int(arc4random()) % d
                }
                d = BaseCalculate(d: d, s: s)
            }
            
            //store results
            data.result[i] = d / 4
        }
    }
    
    mutating func Parser(hexagrams:[Hexagram]) {
        //clears explanations
        data.explanation1 = [""]
        data.explanation2 = [""]
        
        //calculate ben and zhi hexagram part1 and part2
        var benPart1 = 0
        var benPart2 = 0
        var zhiPart1 = 0
        var zhiPart2 = 0
        for i in 0..<3 {
            benPart1 |= (((data.result[i] == 6) || (data.result[i] == 8)) ? 1 : 0) << (2 - i)
            zhiPart1 |= (((data.result[i] == 9) || (data.result[i] == 8)) ? 1 : 0) << (2 - i)
            benPart2 |= (((data.result[i + 3] == 6) || (data.result[i + 3] == 8)) ? 1 : 0) << (2 - i)
            zhiPart2 |= (((data.result[i + 3] == 9) || (data.result[i + 3] == 8)) ? 1 : 0) << (2 - i)
        }
        
        //gets the ben hexagram and zhi hexagram
        let benHexagram = hexagrams.filter { $0.id == (8 * benPart1) + (benPart2 + 1) }[0]
        let zhiHexagram = hexagrams.filter { $0.id == (8 * zhiPart1) + (zhiPart2 + 1) }[0]
        
        //gets the ben hexagram id, type, name and pinyin
        data.benId = benHexagram.id
        data.benType = benHexagram.type
        data.benName = benHexagram.name
        data.benPinyin = benHexagram.pinyin
        
        //gets the zhi hexagram id, type, name and pinyin
        data.zhiId = zhiHexagram.id
        data.zhiType = zhiHexagram.type
        data.zhiName = zhiHexagram.name
        data.zhiPinyin = zhiHexagram.pinyin
        
        //calculate the number of change
        //calculate the change yaos
        var change = 0
        var changeYaos = 0
        for i in 0..<6 {
            if data.result[i] == 9 || data.result[i] == 6 {
                change += 1
                changeYaos = changeYaos | (1 << i)
            }
        }
        
        //gets the change yaos
        data.changeYaos = changeYaos
        
        //gets the explanations
        switch change {
            case 0:
                data.explanation1 = benHexagram.explanations[0]
            case 1:
                for i in 0..<6 {
                    if data.result[i] == 9 || data.result[i] == 6 {
                        data.explanation1 = benHexagram.explanations[i + 1]
                        break
                    }
                }
            case 2:
                for i in 0..<6 {
                    if data.result[i] == 9 || data.result[i] == 6 {
                        if data.explanation2 == [""] {
                            data.explanation2 = benHexagram.explanations[i + 1]
                        } else {
                            data.explanation1 = benHexagram.explanations[i + 1]
                        }
                    }
                }
            case 3:
                data.explanation1 = benHexagram.explanations[0]
                data.explanation2 = zhiHexagram.explanations[0]
            case 4:
                for i in 0..<6 {
                    if data.result[i] == 7 || data.result[i] == 8 {
                        if data.explanation1 == [""] {
                            data.explanation1 = zhiHexagram.explanations[i + 1]
                        } else {
                            data.explanation2 = zhiHexagram.explanations[i + 1]
                        }
                    }
                }
            case 5:
                for i in 0..<6 {
                    if data.result[i] == 7 || data.result[i] == 8 {
                        data.explanation1 = benHexagram.explanations[i + 1]
                        break
                    }
                }
            case 6:
                data.explanation1 = zhiHexagram.explanations[0]
            default:
                data.explanation1 = ["error"]
                data.explanation2 = ["error"]
        }
    }
}
