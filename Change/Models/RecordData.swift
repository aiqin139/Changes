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

func loadRecord<T: Decodable>() -> T {
    let data: Data
    
    let filename: String = "record.json"
    let filePath = NSHomeDirectory() + "/Documents/\(filename)"

    if !FileManager.default.fileExists(atPath: filePath) {
        clearRecord()
    }
    
    do {
        data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func saveRecord<T: Encodable>(_ fileData: T) {
    let data: Data
    let filename: String = "record.json"
    
    do {
        let encoder = JSONEncoder()
        data = try encoder.encode(fileData)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
    do {
        let filePath = NSHomeDirectory() + "/Documents/\(filename)"
        try data.write(to: URL(fileURLWithPath: filePath))
    } catch {
        fatalError("Couldn't save \(filename) as \(T.self):\n\(error)")
    }
}

func clearRecord() {
    saveRecord([RecordData()])
}
