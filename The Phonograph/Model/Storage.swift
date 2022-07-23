//
//  Storage.swift
//  The Phonograph
//
//  Created by Wind Versi on 17/7/22.
//

import Foundation

class Storage {
    
    private func getFileUrl(path: String) -> URL {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0].appendingPathComponent(path)
    }
        
    func getItems<T: Decodable>(filename: String) -> [T]? {
        let fileUrl = getFileUrl(path: filename)
        let data: Data
        
        do {
            data = try Data(contentsOf: fileUrl)
        } catch {
            print("Couldn't load \(filename) from Storage:\n\(error)")
            return nil
        }
        
        do {
            let items = try JSONDecoder().decode([T].self, from: data)
            return items
        } catch {
            print("Couldn't parse \(filename) as \(T.self):\n\(error)")
            return nil
        }
    }
    
    func saveItems<T: Encodable>(filename: String, items: [T]) {
        let fileUrl = getFileUrl(path: filename)
        let data: Data
        
        do {
            data = try JSONEncoder().encode(items)
        } catch {
            print("Couldn't parse \(filename) \n\(error)")
            return
        }
        
        do {
            try data.write(to: fileUrl)
        } catch {
            print("Couldn't to Storage \(filename) as \(T.self):\n\(error)")
        }
    }
    
}
