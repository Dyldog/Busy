//
//  Day.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation
import SwiftUI

enum Day: Int, CaseIterable, Identifiable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var id: Int { rawValue }
    
    var name: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }
}

extension Day {
    static func allDays(from startDay: Day) -> [Day] {
        (Self.allCases[startDay.rawValue...] + Self.allCases[0..<startDay.rawValue]).array()
    }
    
    static func remainingWeekDays(from startDay: Day) -> [Day] {
        Self.allCases[startDay.rawValue...].array()
    }
    
    var next: Day {
        Day(rawValue: (rawValue + 1) % Self.allCases.count)!
    }
}

extension Day {
    var color: Color {
        switch self {
        case .monday: return .red
        case .tuesday: return .orange
        case .wednesday: return .yellow
        case .thursday: return .green
        case .friday: return .blue
        case .saturday: return .indigo
        case .sunday: return .purple
        }
    }
}
