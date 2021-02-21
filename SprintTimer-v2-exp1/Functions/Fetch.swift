//
//  Fetch.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/21/21.
//

import SwiftUI

func getTimerItemLabel(timer: SprintTimerItem) -> SprintTimerLabel {
    var name: String

    switch timer.type {
    case .warmup:
        name = "Warmup"
    case .mediumPace:
        name = "Medium Pace"
    case .cooldown:
        name = "Cooldown"

    default:
        name = "Blarg"
    }
    
    return SprintTimerLabel(name: name,
                            value: formatSecondsToTimeString(timer.duration))
}
