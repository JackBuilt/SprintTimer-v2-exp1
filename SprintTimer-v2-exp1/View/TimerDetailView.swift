//
//  TimerDetailView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

struct TimerDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var timerController: SprintTimerController
    //@State private var showActiveAlert: Bool = false
    private var sprintTimer: SprintTimer
    
    /// If this is true and timerController.timerIsActive is false, show TimerDetailCompletedView view.
    @State private var allowCompletionView: Bool = false
    
    
    
    
    init(_ sprintTimer: SprintTimer)
    {
        self.sprintTimer = sprintTimer
        self.timerController = SprintTimerController(sprintTimer)
    }
    
    
    var body: some View {
        VStack {
            Section {
                List {
                    if timerController.timerIsActive {
                        TimerDetailRunningView(sprintTimer: self.sprintTimer, timerController: self.timerController)
                    }
                    else if self.allowCompletionView && !timerController.timerIsActive {
                        TimerDetailCompletedView(sprintTimer: self.sprintTimer,
                                                 allowCompletionView: $allowCompletionView)
                    }                    
                    else {
                        TimerDetailSummaryView(sprintTimer: self.sprintTimer)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        /// Back button
                        Button(action: {
                            closeTimer()
                        }) {
                            Image(systemName: "arrow.backward.square.fill")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        /// Edit timer
                        Button(action: {
                            editTimer()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 26))
                        }
                    }
                }
                .navigationBarTitle("\(sprintTimer.name)", displayMode: .inline)
            }
            
            if !self.allowCompletionView || timerController.timerIsActive {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 20) {
                            // Buttons
                            if timerController.mode == AppTimer.timerMode.stopped {
                                TimerButton(label: "Start", buttonColor: .green)
                                    .onTapGesture {
                                        self.timerController.start(true)
                                        self.allowCompletionView = true
                                        //self.sounds.playSound(.buttonClick)
                                    }
                            }
                            else if timerController.mode == AppTimer.timerMode.running {
                                TimerButton(label: "Pause", buttonColor: .blue)
                                    .onTapGesture {
                                        self.timerController.pause()
                                        //self.sounds.playSound(.buttonClick)
                                    }
                            }
                            else if timerController.mode == AppTimer.timerMode.paused {
                                TimerButton(label: "Continue", buttonColor: .purple)
                                    .onTapGesture {
                                        self.timerController.start(false)
                                        //self.sounds.playSound(.buttonClick)
                                    }

                                TimerButton(label: "Stop", buttonColor: .red)
                                    .onTapGesture {
                                        self.timerController.stop()
                                        self.allowCompletionView = false
                                        //self.sounds.playSound(.buttonClick)
                                    }
                            }
                        }
                        Spacer()
                    }
                }   // END Section
                .padding(10)
            }
        }
    }
    
    
    func editTimer() {
        self.timerController.stop()
        self.allowCompletionView = false
        viewRouter.selectedTimer = sprintTimer
        withAnimation {
            viewRouter.currentPage = .timerEditView
        }
    }
    
    func closeTimer() {
        self.timerController.stop()
        self.allowCompletionView = false
        withAnimation {
            viewRouter.currentPage = .timerSelectView
        }
    }
    
}

struct TimerDetailView_Previews: PreviewProvider {
    static func timer() -> SprintTimer {
        let t = SprintTimer()
        t.name = "Blarg Timer"
        return t
    }
    static var previews: some View {
        TimerDetailView(timer())
    }
}
