//
//  Utils.swift
//  The Phonograph
//
//  Created by Wind Versi on 12/7/22.
//

import Foundation

class Utils {
    
    static func loadData<T: Codable>(_ filename: String) -> T {
        let data: Data
        
        let filePath = Bundle(for: self).path(forResource: filename, ofType: "json")
        
        guard let file = filePath else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        let url = URL(fileURLWithPath: file)
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
}

