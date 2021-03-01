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
    
    var currentEvent: EventDate = EventDate()
    var nextEvent: EventDate = EventDate()
    /// Returns the number of seconds remaining in te curent event.
    var currentEventSecondsRemaining: Int = 0
    
    @Published var timerIsActive: Bool = false
    //@Published var showCompletionView: Bool = false
    
    init (_ sprintTimer: SprintTimer) {
        self.sprintTimer = sprintTimer
    }
    
    
    // MARK: - Overrides for AppTimer
    /// Override the AppTimer.start() func to reset variables.
    override func start(_ reset: Bool = true) {
        super.start(reset)
        if reset {
            loadEventsArray()
        }
        timerIsActive = true
        //showCompletionView = false
    }
 
    override func stop() {
        super.stop()
        //self.timerIsActive = false = false  need to set flag to trigger view somehow.
        timerIsActive = false
        //showCompletionView = false
    }
    
    /// Override the AppTimer.updateTimer() func so that we can use the interval trigger in this class too!
    override func updateTimer() {
        super.updateTimer()
        checkForEvent()
    }
    // END of AppTimer overrides.
    
    
    /// Fires each second.
    func checkForEvent() {
        let diff = Calendar.current.dateComponents([.second], from: super.date!, to: self.nextEvent.date)
        
        /// This needs some work to display a proper countdown.
        currentEventSecondsRemaining = diff.second!
        
        if diff.second! <= 0 {
            executeEvent()
            setNextEventDate()
        }
//        else {
//            //setCurrentEventCountdown()
//            currentEventSecondsRemaining = diff.second!
//        }
    }
    
    /// Called when an event date is found.
    func executeEvent() {
        let current = self.nextEvent
        
        print("Event starting for :\(TimerType.displayName(current.event.type))")
        
        if current.event.type == .finished {
            stop()
        }
    }
    
    
    /// Loads the upcoming event date variable.
    func setNextEventDate() {
        for event in self.timerEvents {
            if event.date > self.nextEvent.date {
                self.currentEvent = self.nextEvent
                self.nextEvent = event
                return
            }
        }
        //stop()  can't call this here because it will end the timer as the final stage begins.
        // Unless I add a finished stage?
    }
    
//    func setCurrentEventCountdown() {
//        //let endDate =
//
//        /// Add duration to event startDate to get endDate.
//        /// get diff between endDate and startDate
//
//        currentEventSecondsRemaining = 0
//    }
    
    /// Creates an array of dates for each event.
    func loadEventsArray() {
        let startDate: Date = super.startTime!
        let curr = Calendar.current
        self.timerEvents = []
        var dateComponents = curr.dateComponents([.second], from: startDate)
        
        /// Start with zero. I may need to add 1 or 2 seconds to the start.
        dateComponents.second! = 1
        for event in sprintTimer.items {
            self.timerEvents.append(EventDate(curr.date(byAdding: dateComponents,
                                                        to: startDate)!, event))
            dateComponents.second! += event.duration
        }
        /// Add a finished event.
        let finish = SprintTimerItem(.finished, 0)
        self.timerEvents.append(EventDate(curr.date(byAdding: dateComponents,
                                                    to: startDate)!, finish))
        /// Set the next event variable to the first event.
        self.nextEvent = self.timerEvents[0]
        self.currentEvent = self.timerEvents[0]
    }
    
    
}
