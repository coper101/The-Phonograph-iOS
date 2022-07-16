//
//  Stopwatch.swift
//  The Phonograph
//
//  Created by Wind Versi on 16/7/22.
//

import Foundation

import Combine
import Foundation

class Stopwatch: ObservableObject {
    
    @Published var startTime: Date?
    var timer: Cancellable?
    @Published var elapseTime: TimeInterval = .zero
    
    func elapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
    func startTimer(duration: TimeInterval) {
        self.startTime = Date()
        timer?.cancel()
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapseTime = self.elapsedTime()
            }
    }
    
}
