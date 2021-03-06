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
    
    init (_ sprintTimer: SprintTimer) {
        self.sprintTimer = sprintTimer
    }
    
    
    // MARK: - Overrides for AppTimer
    /// Override the AppTimer.start() func to reset variables.
    override func start(_ reset: Bool = true) {
        super.start(reset)
        loadEventsArray()
        if reset {
            checkForEvent()
            executeFirstEvent()
        }
        timerIsActive = true
    }
 
    override func stop() {
        super.stop()
        timerIsActive = false
    }
    
    /// Override the AppTimer.updateTimer() func so that we can use the interval trigger in this class too!
    override func updateTimer() {
        super.updateTimer()
        checkForEvent()
    }
    // END of AppTimer overrides.
    
    
    /// Fires each second.
    func checkForEvent() {
        currentEventSecondsRemaining = Int(self.nextEvent.date.timeIntervalSince1970) - Int(super.date!.timeIntervalSince1970)
        //print(currentEventSecondsRemaining)
        if currentEventSecondsRemaining <= 0 {
            executeEvent()
            setNextEventDate()
            currentEventSecondsRemaining = self.nextEvent.event.duration == 0 ? self.currentEvent.event.duration : self.nextEvent.event.duration
        }
    }
    
    /// Called when an event date is found.
    func executeEvent() {
        let current = self.nextEvent
        
        print("Event starting for :\(TimerType.displayName(current.event.type))")
        
        if current.event.type == .finished {
            stop()
        }
    }
    
    /// Called when starting a resetting the timer.
    func executeFirstEvent() {
        let current = self.timerEvents[0]
        
        print("First Event starting for :\(TimerType.displayName(current.event.type))")
    }
    
    /// Loads the upcoming event date variable.
    func setNextEventDate() {
        var pe: EventDate = self.timerEvents[0]
        for event in self.timerEvents {
            if event.date > super.date! {
                self.currentEvent = pe
                self.nextEvent = event
                //print("currentEvent:\(currentEvent.date) | nextEvent:\(nextEvent.date)")
                return
            }
            pe = event
        }
    }
    
    /// Creates an array of dates for each event.
    func loadEventsArray() {
        //print(super.startTime!)
        //print("\(super.startTime!) > \(super.date!)")
        let startDate: Date = super.startTime!
        let curr = Calendar.current
        self.timerEvents = []
        var dateComponents = curr.dateComponents([.second], from: startDate)
        
        /// Start with zero. I may need to add 1 or 2 seconds to the start.
        dateComponents.second! = 0
        for event in sprintTimer.items {
            self.timerEvents.append(EventDate(curr.date(byAdding: dateComponents,
                                                        to: startDate)!, event))
            dateComponents.second! += event.duration
        }
        /// Add a finished event.
        let finish = SprintTimerItem(.finished, 0)
        self.timerEvents.append(EventDate(curr.date(byAdding: dateComponents,
                                                    to: startDate)!, finish))
        setNextEventDate()
    }
    
    // This might be a better way to add seconds to date.
    // let blarg = Date(timeIntervalSinceNow: Double(self.nextEvent.event.duration))
    
}
