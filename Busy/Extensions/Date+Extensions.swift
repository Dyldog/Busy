//
//  Date+Extensions.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation

extension Date {
    func isBeforeHour(_ hour: Int) -> Bool {
        return Calendar.autoupdatingCurrent.component(.hour, from: self) < hour
    }
    
    var monday: Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        comps.weekday = 2 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
}
