//
//  ModelData.swift
//  Change
//
//  Created by aiqin139 on 2021/1/28.
//

import Foundation

var baseHexagrams: [BaseHexagramModel] = load("baseHexagramData.json")
var combineHexagrams: [CombineHexagramModel] = load("combineHexagramData.json")

func load<T: Decodable>(_ filename: String) -> T
{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else
    {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do
    {
        data = try Data(contentsOf: file)
    }
    catch
    {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do
    {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch
    {
        fatalError("Couldn't parse \(filename) sa \(T.self):\n\(error)")
    }
}
