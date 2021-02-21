//
//  ViewRouter.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    /// The currently displayed page.
    @Published var currentPage: Page = .timerSelectView
    
    /// Need this for rendering TimerView()
    @Published var selectedTimer: SprintTimer = SprintTimer()
    @Published var newTimer: Bool = false
}


// MARK: - Page
/// This enum holds all available pages the app can render.

enum Page {
    case timerSelectView
    case timerDetailView
    case timerEditView
}
