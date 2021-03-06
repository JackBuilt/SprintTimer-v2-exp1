//
//  SprintTimerController.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/23/21.
//

import SwiftUI
 
class SprintTimerController: AppTimer  {

    @Published var timerIsActive: Bool = false
    @Published var currentEventSecondsRemaining: Int = 0
    @Published var currentEvent: EventDate = EventDate()
    @Published var nextEvent: EventDate = EventDate()
    
    @Published var completions: String = ""
    private var completedEvents: Int = 0
    
    private var sprintTimer: SprintTimer
    private var timerEvents: [EventDate] = []
    private let bgSounds: TimerSounds = TimerSounds()
    
    
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
        self.bgSounds.Play(.bgsound, loop: -1)
    }
 
    override func stop() {
        super.stop()
        self.timerIsActive = false
        self.bgSounds.Stop()
    }
    
    override func pause() {
        super.pause()
        self.bgSounds.Stop()
    }
    
    override func updateTimer() {
        super.updateTimer()
        checkForEvent()
    }
    // END of AppTimer overrides.
    
    
    /// Fires each second.
    private func checkForEvent() {
        currentEventSecondsRemaining = Int(self.nextEvent.date.timeIntervalSince1970) - Int(super.date!.timeIntervalSince1970)
        //print(currentEventSecondsRemaining)
        if currentEventSecondsRemaining <= 0 {
            executeEvent()
            setNextEventDate()
            setCompletedEvents()
            currentEventSecondsRemaining = self.nextEvent.event.duration == 0 ? self.currentEvent.event.duration : self.nextEvent.event.duration
        }
    }
    
    /// Called when an event date is found.
    private func executeEvent() {
        let current = self.nextEvent
        
        print("Event starting for :\(TimerType.displayName(current.event.type))")
        
        if current.event.type == .finished {
            stop()
        }
    }
    
    /// Called when resetting the timer.
    private func executeFirstEvent() {
        let first = self.timerEvents[0]
        setCompletedEvents()
        
        print("First Event starting for :\(TimerType.displayName(first.event.type))")
    }
    
    /// Loads the current and next event date variables.
    private func setNextEventDate() {
        var counter = -1
        var pe: EventDate = self.timerEvents[0]
        for event in self.timerEvents {
            if event.date > super.date! {
                self.currentEvent = pe
                self.nextEvent = event
                self.completedEvents = counter
                //print("currentEvent:\(currentEvent.date) | nextEvent:\(nextEvent.date)")
                return
            }
            pe = event
            counter += 1
        }
    }
    
    private func setCompletedEvents() {
        self.completions = "\(self.completedEvents) of \(self.timerEvents.count - 1)"
    }
    
    /// Creates an array of dates for each event.
    private func loadEventsArray() {
        //print(super.startTime!)
        //print("\(super.startTime!) > \(super.date!)")
        let startDate: Date = super.startTime!
        let curr = Calendar.current
        self.timerEvents = []
        var dateComponents = curr.dateComponents([.second], from: startDate)
        
        /// This number will add an offset to the start of the first event.
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
