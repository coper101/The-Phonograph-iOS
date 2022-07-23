//
//  Numbers.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation

extension Int {
    
    func toMinSecTimeFormat() -> String {
        let timeInterval = TimeInterval(self)
        let time = NSInteger(timeInterval)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: "%2d:%0.2d", minutes, seconds)
    }
    
}
