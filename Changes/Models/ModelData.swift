//
//  ModelData.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var digitalPrediction: DigitalPrediction = DigitalPrediction()
    @Published var dayanPrediction: DayanPrediction = DayanPrediction()
    @Published var basicHexagrams: [Hexagram] = load("basicHexagramData.json")
    @Published var derivedHexagrams: [Hexagram] = load("derivedHexagramData.json")
    @Published var hexagramRecord: [RecordData] = loadRecord()
    @Published var fortuneTellingPurpose: String = "时运"
    @Published var searchBarText: String = ""
    @Published var isTabBarHidden: Bool = false
    @Published var isDigitalPresented: Bool = false
    @Published var isDayanPresented: Bool = false
    
    init() {
        digitalPrediction.data = hexagramRecord.filter{ $0.type == RecordType.Digital.rawValue }.last?.digit ?? DigitalData()
        dayanPrediction.data = hexagramRecord.filter{ $0.type == RecordType.Dayan.rawValue }.last?.dayan ?? DayanData()
        
        if (RecordType.Digital.rawValue == hexagramRecord.last?.type) {
            fortuneTellingPurpose = hexagramRecord.last?.digit.purpose ?? "时运"
        }
        else if (RecordType.Dayan.rawValue == hexagramRecord.last?.type) {
            fortuneTellingPurpose = hexagramRecord.last?.dayan.purpose ?? "时运"
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T
{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
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
