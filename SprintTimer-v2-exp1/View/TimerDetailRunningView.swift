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
        HStack {
            Text("Total Time")
                .font(.title2)
                .foregroundColor(Color("AccentColor"))
            Spacer()
            Text("\(formatSecondsToTimeString(self.sprintTimer.totalTime()))")
                .font(.title2)
        }
        
        Section(header: Text("Activity Details").padding(.leading, 20)) {
            SprintTimerLabel(name: "Elapsed Time", value: "\(timerController.secondsElapsed)",
                             smallDisplay: isSmallDisplay)
            SprintTimerLabel(name: "Next Interval",
                             value: "\(TimerType.displayName(timerController.nextEvent.event.type))",
                             smallDisplay: isSmallDisplay)
            SprintTimerLabel(name: "Current Interval",
                             value: "\(formatSecondsToTimeString(timerController.currentEventSecondsRemaining))",
                             altText: "\(TimerType.displayName(timerController.currentEvent.event.type))",
                             valueColor: .green, altTextColor: .orange,
                             smallDisplay: isSmallDisplay)
            SprintTimerLabel(name: "Time Remaining",
                             value: "\(sprintTimer.totalTime() - timerController.secondsElapsed)",
                             smallDisplay: isSmallDisplay)
        }
        
//        Section {
//            ForEach(timerController.timerEvents) { event in
//                Text("\(event.date)")
//            }
//        }
    }
}

