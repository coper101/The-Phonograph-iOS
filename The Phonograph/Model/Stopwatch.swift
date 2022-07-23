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
    @Published var lastElapseTime: TimeInterval = .zero
    
    func elapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
    func startTimer(
        duration: TimeInterval,
        lastElapsedTime: TimeInterval,
        onEnded: @escaping () -> Void
    ) {
        self.startTime = Date()
        resetTimer()
        lastElapseTime = lastElapsedTime
        elapseTime = lastElapsedTime
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                guard self.elapseTime < duration else {
                    onEnded()
                    self.resetTimer()
                    return
                }
                self.elapseTime = self.elapsedTime() + lastElapsedTime
            }
    }
    
    func resetTimer() {
        guard let timer = timer else { return }
        timer.cancel()
        elapseTime = .zero
    }
    
}
