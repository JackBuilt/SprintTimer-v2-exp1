//
//  Timer.swift
//  RunAppInBackgroundExploit_Example
//
//  Created by Jack Smith on 2/12/21.
//

import SwiftUI

class AppTimer {
    
    @Published var mode: timerMode = .stopped
    @Published var secondsElapsed = 0
    @Published var date: Date?
    
    private var timer: Timer?
    private var startTime: Date?
    
    private func createTimer() {
      //if timer == nil {
        let t = Timer(timeInterval: 1.0,
          target: self,
          selector: #selector(updateTimer),
          userInfo: nil,
          repeats: true)
        RunLoop.current.add(t, forMode: .common)
        t.tolerance = 0.1
        
        self.timer = t
      //}
    }
    
    @objc func updateTimer() {
        date = Date()
        secondsElapsed = calculateSecondsElapsed()
        //print("AppTimer.updateTimer()")
    }
    
    func start(_ reset: Bool = true) {
        mode = .running
        if reset {
            startTime = Date()
            secondsElapsed = 0
            date = Date()
        }
        else {
            // Update startTime by subtracting secondsElapsed when paused from current date.
            let newTime = Date()
            startTime = newTime.addingTimeInterval(TimeInterval(-secondsElapsed))
        }
        createTimer()
    }
    
    func pause() {
        timer?.invalidate()
        mode = .paused
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        mode = .stopped
    }
    
    
    private func calculateSecondsElapsed() -> Int {
        let diffComp = Calendar.current.dateComponents([.second], from: startTime!, to: date!)
        let seconds = diffComp.second
        return seconds ?? 0
    }
    
    
    enum timerMode {
        case running
        case stopped
        case paused
    }
    
}

