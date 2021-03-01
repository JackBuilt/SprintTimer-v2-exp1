//
//  TimerDetailCompletedView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/28/21.
//

import SwiftUI

struct TimerDetailCompletedView: View {
    
    @Binding var allowCompletionView: Bool
    //var timerController: SprintTimerController
    
    var body: some View {
        VStack {
            Text("Great job!\nYou've completed your workout.")
            
            HStack {
                Spacer()
                TimerButton(label: "Close", buttonColor: .purple)
                    .onTapGesture {
                        self.allowCompletionView = false
                        //timerController.setShowCompletionView(false)
                    }
                Spacer()
            }
        }
    }
}


