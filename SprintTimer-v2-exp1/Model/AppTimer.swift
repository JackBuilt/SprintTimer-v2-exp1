//
//  Timer.swift
//  RunAppInBackgroundExploit_Example
//
//  Created by Jack Smith on 2/12/21.
//

import SwiftUI

class AppTimer: ObservableObject {
    
    @Published var mode: timerMode = .stopped
    @Published var secondsElapsed = 0
    @Published var date: Date?
    
    public var startTime: Date?
    private var timer: Timer?
    
    
    
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
    }
    

    func start(_ reset: Bool = true) {
        mode = .running
        if reset {
            startTime = Date()
            secondsElapsed = 0
            date = startTime
            //print("AppTimer: \(startTime!)")
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
        let seconds = diffComp.second ?? 0
        return seconds
    }
    
    
    enum timerMode {
        case running
        case stopped
        case paused
    }
    
}

