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
                    withAnimation {
                        viewRouter.currentPage = .timerDetailView
                    }
                }) {
                    SprintTimerLabel(name: "\(timer.name)",
                                     value: "\(formatSecondsToTimeString(timer.totalTime()))")
                }
            }
            .onDelete(perform: onDelete)    //timerDataController.remove)
            .onMove(perform: onMove)

        }
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                // New timer.
                Button(action: {
                    viewRouter.selectedTimer = SprintTimer()
                    viewRouter.newTimer = true
                    withAnimation {
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
        .navigationBarTitle("Select a Program", displayMode: .inline)
        //.environment(\.editMode, $editMode)
    }
    
    
    private func onDelete(offsets: IndexSet) {
        timerDataController.remove(at: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        timerDataController.move(from: source, to: destination)
    }
    
}

struct TimerSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectView()
    }
}
