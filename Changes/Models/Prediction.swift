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


struct DayanProcessData : Hashable, Codable {
    var partA: Int = 0
    var partB: Int = 0
    var modA: Int = 0
    var modB: Int = 0
    var remain: Int = 0
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
    
    private func BaseCalculate(remain: Int, random: Int) -> DayanProcessData {
        var res = DayanProcessData()
        res.partA = random - 1
        res.partB = remain - random
        res.modA = ((res.partA % 4) != 0) ? (res.partA % 4) : 4
        res.modB = ((res.partB % 4) != 0) ? (res.partB % 4) : 4
        res.remain = remain - res.modA - res.modB - 1
        return res
    }
    
    mutating func Execute(_ part: Int, _ step: Int, _ remain: Int) -> DayanProcessData {
        //initial
        var res = DayanProcessData(partA: 0, partB: 0, modA: 0, modB: 0, remain: remain)
        
        //six parts
        if part >= 0 && part < 6 {

            //three steps
            if step >= 0 && step < 3 {
                var random = 0
                while random <= 1 {
                    random = Int(arc4random()) % res.remain
                }
                
                res = BaseCalculate(remain: res.remain, random: random)
            }

            //store results
            if step == 2 { data.result[part] = res.remain / 4 }
        }
        
        return res
    }
    
    mutating func Execute() {
        //six parts
        for i in 0..<6 {
            var remain = 50 - 1
            
            //three steps
            for _ in 0..<3 {
                var random = 0
                while random <= 1 {
                    random = Int(arc4random()) % remain
                }
                remain = BaseCalculate(remain: remain, random: random).remain
            }
            
            //store results
            data.result[i] = remain / 4
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
