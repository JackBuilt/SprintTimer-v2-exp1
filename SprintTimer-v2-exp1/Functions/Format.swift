//
//  Format.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI


// MARK: - formatSecondsToTimeString()
/// Format seconds for display label.

func formatSecondsToTimeString(_ seconds: Int) -> String {
    let h: Int = seconds/3600
    let m: Int = seconds/60%60
    let s: Int = (seconds%60)

    var value = ""
    if h > 0 {
        value = "\(String(h)):"
    }
    if m > 0 || h > 0 {
        if h > 0 {
            value +=  String(format: "%02d", m)
        }
        else {
            value +=  String(format: "%d", m)
        }
    }
    value += String(format: ":%02d", s)

    return value
}
