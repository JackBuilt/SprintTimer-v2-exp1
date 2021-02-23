//
//  SprintTimer.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/20/21.
//

import SwiftUI


class SprintTimer: ObservableObject, Identifiable, Decodable, Encodable {
    
    var id: UUID
    var name: String
    var items: [SprintTimerItem]
    
    init() {
        self.id = UUID()
        self.name = ""
        self.items = [SprintTimerItem]()
    }
    
    func totalTime() -> Int {
        var time: Int = 0
        for t in items {
            time += t.duration
        }
        return time
    }
}


class SprintTimerItem: Identifiable, Decodable, Encodable {
    
    var id: UUID
    var type: TimerType
    var duration: Int
    
    init() {
        self.id = UUID()
        self.type = .none
        self.duration = -1
    }
    
    init(_ type: TimerType, _ seconds: Int) {
        self.id = UUID()
        self.type = type
        self.duration = seconds
    }
}


enum TimerType: Decodable, Encodable {
    case none
    case warmup
    case easyPace
    case mediumPace
    case fastPace
    case sprint
    case cooldown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        switch try container.decode(String.self) {
        case "None":
            self = .none
        case "Warmup":
            self = .warmup
        case "Easy Pace":
            self = .easyPace
        case "Medium Pace":
            self = .mediumPace
        case "Fast Pace":
            self = .fastPace
        case "Sprint":
            self = .sprint
        case "Cooldown":
            self = .cooldown
        default:
            fatalError()
        }

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .none:
            try container.encode("None")
        case .warmup:
            try container.encode("Warmup")
        case .easyPace:
            try container.encode("Easy Pace")
        case .mediumPace:
            try container.encode("Medium Pace")
        case .fastPace:
            try container.encode("Fast Pace")
        case .sprint:
            try container.encode("Sprint")
        case .cooldown:
            try container.encode("Cooldown")
//        default:
//            fatalError()
        }
    }
    
    /// Returns a friendly display name.
    static func displayName(_ type: TimerType) -> String {
        switch type {
        case .warmup:
            return "Warmup"
        case .easyPace:
            return "Easy Pace"
        case .mediumPace:
            return "Medium Pace"
        case .fastPace:
            return "Fast Pace"
        case .sprint:
            return "Sprint"
        case .cooldown:
            return "Cooldown"
        default:
            return ""
        }
    }
    
}
