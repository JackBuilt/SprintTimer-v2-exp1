//
//  TimerDetailView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

struct TimerDetailView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    private var sprintTimer: SprintTimer
    
    
    init(_ sprintTimer: SprintTimer)
    {
        self.sprintTimer = sprintTimer
    }
    
    
    var body: some View {
        List {
            
            Section {
                ForEach(sprintTimer.items) { item in
                    getTimerItemLabel(timer: item)
                }
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                /// Mute sound
//                Button(action: {
//                    //self.timerController.isMuted.toggle()
//                }) {
//                    HStack {
//                        Text("") /// Unfuckingbelievable... Only by adding this empty text can you change the color.
//                        Image(systemName: timerController.isMuted ? "speaker.slash.fill" : "speaker.1.fill")
//                            .font(.system(size: 26))
//                            .foregroundColor(timerController.isMuted ? .red : .green)
//                    }
//                }
//                .frame(width: 25)
//            }
        }
        .navigationBarTitle("\(sprintTimer.name)", displayMode: .inline)
    }
    
    
    func editTimer() {
        //self.timerController.stop()
        viewRouter.selectedTimer = sprintTimer
        viewRouter.currentPage = .timerEditView
    }
    
    func closeTimer() {
        //self.timerController.stop()
        viewRouter.currentPage = .timerSelectView
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
