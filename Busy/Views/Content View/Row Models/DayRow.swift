//
//  DayRow.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation
import SwiftUI

enum DayPeriod {
    case day
    case night
    case wholeDay
    
    var startHour: Int {
        switch self {
        case .day: return 9
        case .night: return 12 + 5
        case .wholeDay: return 12
        }
    }
}

struct DayRow: Identifiable {
    let id: Int
    let name: String
    let dayEvents: [EventRow]
    let nightEvents: [EventRow]
    let onSelect: (DayPeriod) -> Void
}

extension DayRow {
    var hasEvents: Bool {
        return !dayEvents.isEmpty || !nightEvents.isEmpty
    }
}
