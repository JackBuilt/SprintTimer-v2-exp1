//
//  EventDate.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/25/21.
//

import SwiftUI

class EventDate: Identifiable {
    var id = UUID()
    var date: Date
    var event: SprintTimerItem
    
    init() {
        self.date = Date()
        self.event = SprintTimerItem()
    }
    init(_ date: Date, _ event: SprintTimerItem) {
        self.date = date
        self.event = event
    }
}
