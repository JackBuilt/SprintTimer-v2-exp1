//
//  Color.swift
//  SprintTimer-v1
//
//  Created by Jack Smith on 2/13/21.
//

import SwiftUI


// MARK: - Gradient Color picker
/// Designed for buttons specifically.

enum gradientColors {
    case red
    case green
    case blue
    case purple
}

func getGradientColor(_ color: gradientColors) -> LinearGradient {
    
    var lightColor: Color
    var darkColor: Color

    switch color {
    case .red:
        lightColor = Color(red: 1, green: 0, blue: 0)
        darkColor = Color(red: 0.75, green: 0, blue: 0)
        return LinearGradient(gradient: Gradient(colors: [lightColor, darkColor]),
                              startPoint: .top, endPoint: .bottom)
    
    case .green:
        lightColor = Color(red: 0, green: 0.8, blue: 0)
        darkColor = Color(red: 0, green: 0.62, blue: 0)
        return LinearGradient(gradient: Gradient(colors: [lightColor, darkColor]),
                              startPoint: .top, endPoint: .bottom)
        
    case .blue:
        lightColor = Color(red: 0, green: 0, blue: 1)
        darkColor = Color(red: 0, green: 0, blue: 0.75)
        return LinearGradient(gradient: Gradient(colors: [lightColor, darkColor]),
                              startPoint: .top, endPoint: .bottom)
    
    case .purple:
        lightColor = Color(red: 0.35, green: 0, blue: 0.84)
        darkColor = Color(red: 0.30, green: 0, blue: 0.62)
        return LinearGradient(gradient: Gradient(colors: [lightColor, darkColor]),
                              startPoint: .top, endPoint: .bottom)
    }
}


//func highlightListRow(_ rowId: UUID, _ selectedId: UUID) -> Color {
//    if rowId == selectedId {
//        return .orange
//    }
//    return Color(UIColor.systemGroupedBackground)
//}
