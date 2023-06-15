//
//  ContentViewModel.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    enum Constants {
        static let nightHour = 12 + 5
    }
    
    let eventManager: EventManager = .init()
    let schemeManager: URLSchemeManager = .init()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }()
    
    @Published var colorOffset: Int = 0
    @Published var showSettings: Bool = false

    
    init() {
        eventManager.requestAccess { result in }
        onAppear()
    }
    
    func onAppear() {
        colorOffset = Calendar.autoupdatingCurrent.currentDay.rawValue
    }
    
    private func pluralisedWeeks(for offset: Int) -> String {
        if offset == 1 {
            return "week"
        } else {
            return "weeks"
        }
    }
    
    private func title(for day: Day, weeksAway: Int) -> String {
        switch weeksAway {
        case 0:
            return day.name
        case 1:
            return "\(day.name) next week"
        default:
            return "\(day.name) in \(weeksAway) weeks"
        }
    }
    
    private func rowModel(for day: Day, inWeeks weekOffset: Int) -> DayRow {
        let date = Calendar.autoupdatingCurrent.thisWeekInstance(of: day)
            .addingTimeInterval(.oneWeek * Double(weekOffset))
        let events = self.eventManager.events(for: date).filter {
            eventManager.calendarEnabled(for: $0.calendarID)
        }
        let dayEvents = events.filter {
            $0.start.isBeforeHour(Constants.nightHour)
        }
        
        let nightEvents = events.filter {
            $0.start.isBeforeHour(Constants.nightHour) == false
        }
        
        return .init(
            id: date.hashValue,
            name: title(for: day, weeksAway: weekOffset),
            dayEvents: dayEvents.map { event in
                    .init(
                        id: event.id,
                        title: event.title,
                        startTime: self.timeFormatter.string(from: event.start)
                    )
            }, nightEvents: nightEvents.map { event in
                    .init(
                        id: event.id,
                        title: event.title,
                        startTime: self.timeFormatter.string(from: event.start)
                    )
            }, onSelect: { [weak self] period in
                guard let url = self?.schemeManager.url(for: period, of: date) else { return } // TODO: Handle nil URL
                
                UIApplication.shared.open(url)
            }
        )
    }
    
    private func rowModels(for days: [Day], inWeeks weekOffset: Int) -> [DayRow] {
        return days.map {
            rowModel(for: $0, inWeeks: weekOffset)
        }
    }
    
    func model(for index: Int) -> DayRow {
        let todayIndex = Calendar.autoupdatingCurrent.weekdayIndex(of: .now)
        let cellIndex = todayIndex + index
        let cellDayIndex = cellIndex % 7
        let cellWeekIndex = (cellIndex - cellDayIndex) / 7
        let cellDay = Day(rawValue: cellDayIndex)!
        return rowModel(for: cellDay, inWeeks: cellWeekIndex)
    }
}
