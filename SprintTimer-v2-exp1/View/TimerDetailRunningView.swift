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
//            ForEach(sprintTimer.items) { item in
//                getTimerItemLabel(timer: item)
//            }
            SprintTimerLabel(name: "Elapsed Time", value: "8:47")
            SprintTimerLabel(name: "Next Interval", value: "Fast Pace")
            SprintTimerLabel(name: "Current Interval", value: "Warmup 2:13")
            SprintTimerLabel(name: "Time Remaining", value: "23:42")
        }
        
        Section {
            ForEach(timerController.timerEvents) { event in
                Text("\(event.date)")
            }
        }
    }
}

