//
//  TimerDetailCompletedView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/28/21.
//

import SwiftUI

struct TimerDetailCompletedView: View {
    
    var sprintTimer: SprintTimer
    @Binding var allowCompletionView: Bool

    var body: some View {
        Section {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("Great job!")
                        .font(.title)
                        .foregroundColor(.green)
                    Text("You've completed your workout.")
                        .font(.title3)
                        .foregroundColor(Color("SprintTimerLabelColor"))
                }
                Spacer()
            }
        }
                    
        Section(header: Text("Completed Program Summary").padding(.leading, 20)) {
            ForEach(sprintTimer.items) { item in
                SprintTimerLabel(name: TimerType.displayName(item.type),
                                 value: formatSecondsToTimeString(item.duration),
                                 colorSwatch: getEventColor(item.type))
            }
        }
        
        Section(footer: Text("\(getCompletedTime())").padding(.leading, 10)) {
            HStack {
                Text("Total Time")
                    .font(.title2)
                    .foregroundColor(Color("AccentColor"))
                Spacer()
                Text("\(formatSecondsToTimeString(self.sprintTimer.totalTime()))")
                    .font(.title2)
            }
        }
        
//        Section {
//            HStack {
//                Spacer()
//                TimerButton(label: "Close", buttonColor: .purple)
//                    .onTapGesture {
//                        self.allowCompletionView = false
//                    }
//                Spacer()
//            }
//        }
    }
    
    private func getCompletedTime() -> String {
        let text = "Workout completed on \(format.string(from: Date()))"
        return text
    }
    
    private let format: DateFormatter = {
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        formatter.dateFormat = "EEEE, MMM d, yyyy 'at' h:mm a"
        return formatter
    }()
}


