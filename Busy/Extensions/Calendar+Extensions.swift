//
//  Calendar+Extensions.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation

extension Calendar {
    func weekdayIndex(of date: Date) -> Int {
        let sundayIndex = component(.weekday, from: date)
        return (sundayIndex + 5) % 7
    }
    
    func date(day: Int, month: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        guard let date = date(from: components) else {
            fatalError()
        }
        
        return date
    }
    
    var currentDay: Day {
        Day(rawValue: weekdayIndex(of: .now))!
    }
    
    func thisWeekInstance(of day: Day) -> Date {
        guard day != currentDay else { return .now }
        
        let compsToAdd = DateComponents(day: day.rawValue)
        
        return date(byAdding: compsToAdd, to: .now.monday)!
    }
    
    func nextInstance(of day: Day) -> Date {
        guard day != currentDay else { return .now }
        
        let daysToAdd = Day.allDays(from: currentDay).firstIndex(of: day)!
        
        let compsToAdd = DateComponents(day: daysToAdd)
        
        return date(byAdding: compsToAdd, to: .now)!
    }
}
