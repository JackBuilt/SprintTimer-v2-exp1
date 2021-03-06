//
//  TimerDetailSummaryView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/23/21.
//

import SwiftUI

struct TimerDetailSummaryView: View {
    
    var sprintTimer: SprintTimer
    
    var body: some View {
        HStack {
            Text("Total Time")
                .font(.title2)
                .foregroundColor(Color("AccentColor"))
            Spacer()
            Text("\(formatSecondsToTimeString(self.sprintTimer.totalTime()))")
                .font(.title2)
        }
        
        Section(header: Text("Activity Summary").padding(.leading, 20)) {
            ForEach(sprintTimer.items) { item in
                SprintTimerLabel(name: TimerType.displayName(item.type),
                                 value: formatSecondsToTimeString(item.duration),
                                 colorSwatch: getEventColor(item.type))
            }
        }
    }
}

