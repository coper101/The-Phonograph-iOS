//
//  Numbers.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation

extension Int {
    
    func toMinSecTimeFormat() -> String {
        let milliSec = self * 1000
        let date = Date(timeIntervalSince1970: TimeInterval(milliSec) / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}
