//
//  SprintTimerController.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/23/21.
//

import SwiftUI
 
class SprintTimerController: AppTimer  {

    var sprintTimer: SprintTimer
    var timerEvents: [EventDate] = []
    
    init (_ sprintTimer: SprintTimer) {
        self.sprintTimer = sprintTimer
    }
    
    
    
    func loadEventsArray() {
        let startDate: Date = super.date!
        
        var dateComponents = Calendar.current.dateComponents([.second], from: startDate)
        
        /// Start with zero. I may need to add 1 or 2 seconds to the start.
        dateComponents.second! = 0
        /// Add the start time to the array.
        self.timerEvents.append(EventDate(Calendar.current.date(byAdding: dateComponents, to: startDate)!))
        
        for event in sprintTimer.items {
            /// We have started at 0 now we keep adding duration to the date.
            dateComponents.second! += event.duration
            self.timerEvents.append(EventDate(Calendar.current.date(byAdding: dateComponents, to: startDate)!))
        }
    }
    
    // MARK: - Overrides for AppTimer
    /// Override the AppTimer.start() func to reset variables.
    override func start(_ reset: Bool = true) {
        super.start(reset)
        if reset {
            loadEventsArray()
        }
    }
    
}
