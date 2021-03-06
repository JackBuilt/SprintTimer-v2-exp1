//
//  SprintTimer_v2_exp1App.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

@main
struct SprintTimer_v2_exp1App: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter).environmentObject(viewRouter)
        }
    }
}
