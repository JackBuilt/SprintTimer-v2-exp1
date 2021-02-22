//
//  TimerSelectView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

struct TimerSelectView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @ObservedObject var timerDataController: SprintTimerDataController = SprintTimerDataController()
    //@State private var editMode: EditMode = .inactive
    
    
    var body: some View {
        List {
            
            ForEach(timerDataController.sprintTimerArray) { timer in
                Button(action: {
                    /// Pass the selected timer to the ViewRouter()
                    viewRouter.selectedTimer = timer
                    viewRouter.currentPage = .timerDetailView
                }) {
                    SprintTimerLabel(name: "\(timer.name)",
                                     value: "\(formatSecondsToTimeString(timer.totalTime()))")
                }
            }
            .onDelete(perform: timerDataController.remove)

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                // New timer.
                Button(action: {
                    withAnimation {
                        viewRouter.selectedTimer = SprintTimer()
                        viewRouter.newTimer = true
                        viewRouter.currentPage = .timerEditView
                    }
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "plus.square.fill")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
//                // Edit Mode toggle to delete timers.
//                Button(action: {
//                    editMode = editMode == .inactive ? .active : .inactive
//                }) {
//                    HStack(spacing: 10) {
//                        Text(editMode == .inactive ? "Edit" : "Done")
//                    }
//                }
            }
        }
        .navigationBarTitle("Timer Select", displayMode: .inline)
        //.environment(\.editMode, $editMode)
    }
    
}

struct TimerSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectView()
    }
}
