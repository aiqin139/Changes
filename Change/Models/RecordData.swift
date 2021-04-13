//
//  Record.swift
//  Change
//
//  Created by aiqin139 on 2021/4/10.
//

import Foundation
import SwiftUI

enum RecordType: Int {
    case None = 0
    case Digital = 1
    case Dayan = 2
}

struct RecordData: Hashable, Codable {
    var type: Int = 0
    var digit: DigitalData = DigitalData()
    var dayan: DayanData = DayanData()
    var date: Date = Date()
}

//struct RecordDataManager {
//    public func load<T: Decodable>(_ filename: String) -> T {
//        let data: Data
//
//        let fileManager = FileManager.default
//        let filePath:String = NSHomeDirectory() + "/Documents/record.json"
//        let exist = fileManager.fileExists(atPath: filePath)
//
//        if exist {
//            fatalError("Couldn't find \(filename) in main bundle.")
//        }
//
//        do {
//            data = try Data(contentsOf: file)
//        } catch {
//            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//        }
//    }
//
//    public func save<T: Encodable>(_ filename: String, _ fileData: T)
//    {
//        let data: Data
//
//        do {
//            let encoder = JSONEncoder()
//            data = try encoder.encode(fileData)
//
//            let filePath = NSHomeDirectory() + "/Documents/record.json"
//            try? data.write(to: URL(fileURLWithPath: filePath))
//        } catch {
//            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//        }
//    }
//}
