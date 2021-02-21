//
//  ContentView.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    @StateObject var timer: SprintTimer = SprintTimer()
    
    
    var body: some View {
        NavigationView {
            ZStack {    /// Need ZStack for View transitions to work.
                switch viewRouter.currentPage {
                case .timerSelectView:
                    TimerSelectView()
//                        .transition(AnyTransition.scale
//                                        .animation(
//                                            .easeInOut(duration: 0.5)))
                case .timerEditView:
                    TimerEditView(viewRouter.selectedTimer, newTimer: viewRouter.newTimer)
                case .timerDetailView:
                    TimerDetailView(viewRouter.selectedTimer)
                    
//                default:
//                    EmptyView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding(0)
        .accentColor(Color("AccentColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(ViewRouter())
    }
}
