//
//  SprintTimerController.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/23/21.
//

import SwiftUI

class SprintTimerController: AppTimer, ObservableObject  {

    var sprintTimer: SprintTimer
    
    init (_ sprintTimer: SprintTimer) {
        self.sprintTimer = sprintTimer
    }
    
}
