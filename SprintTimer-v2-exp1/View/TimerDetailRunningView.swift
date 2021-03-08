//
//  TimerDetailRunningView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/23/21.
//

import SwiftUI

struct TimerDetailRunningView: View {
    
    var sprintTimer: SprintTimer    // Does this need to be @ObservedObject?
    @ObservedObject var timerController: SprintTimerController
    
    /// Using these to size fonts for split view on iPad.
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    //var isPortrait: Bool {UIDevice.current.orientation.isPortrait}
    var isCompact: Bool {horizontalSizeClass == .compact}
    var isPad: Bool {UIDevice.current.userInterfaceIdiom == .pad}
    var isSmallDisplay: Bool {isPad && isCompact}
    
    
    var body: some View {
        Section {
            SprintTimerLabel(name: "Total Time",
                             value: "\(formatSecondsToTimeString(self.sprintTimer.totalTime()))",
                             nameColor: Color("AccentColor"),
                             smallDisplay: isSmallDisplay)
        }
        
        Section(header: Text("Activity Details").padding(.leading, 20)) {
            SprintTimerLabel(name: "Elapsed Time",
                             value: "\(formatSecondsToTimeString(timerController.secondsElapsed))",
                             smallDisplay: isSmallDisplay)

            SprintTimerLabel(name: "Next Interval",
                             value: "",
                             altText: "\(TimerType.displayName(timerController.nextEvent.event.type))",
                             altTextColor: getEventColor(timerController.nextEvent.event.type),
                             iconTrailing: getIntervalArrow(),
                             //iconTrailingColor: getEventColor(timerController.nextEvent.event.type),
                             iconTrailingColor: Color(red: 0.75, green: 0, blue: 0),
                             smallDisplay: isSmallDisplay)
            /// Should iconTrailingColor always be red since the icon is a heart?
            
            SprintTimerLabel(name: "Current Interval",
                             value: "\(formatSecondsToTimeString(timerController.currentEventSecondsRemaining))",
                             altText: "\(TimerType.displayName(timerController.currentEvent.event.type))",
                             valueColor: getEventColor(timerController.currentEvent.event.type),
                             altTextColor: getEventColor(timerController.currentEvent.event.type),
                             smallDisplay: isSmallDisplay)
            
            SprintTimerLabel(name: "Intervals Completed",
                             value: "\(timerController.completions)",
                             smallDisplay: isSmallDisplay)
            
            SprintTimerLabel(name: "Time Remaining",
                             value: "\(formatSecondsToTimeString(sprintTimer.totalTime() - timerController.secondsElapsed))",
                             smallDisplay: isSmallDisplay)
        }
        
        Section {
            HStack {
                Spacer()
                Text("\(TimerType.displayName(timerController.currentEvent.event.type))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(getEventColor(timerController.currentEvent.event.type))
                    .padding(.bottom, 3)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .frame(minHeight: 100)
        
    }
    
    private func getIntervalArrow() -> String {
        
        if timerController.nextEvent.event.type == .finished {
            return ""
        }
        
        let current = TimerType.typeValue(timerController.currentEvent.event.type)
        let next = TimerType.typeValue(timerController.nextEvent.event.type)
        
        if next > current {
            return "arrow.up.heart.fill"
        }
        else {
            return "arrow.down.heart.fill"
        }
    }
    
    
}

