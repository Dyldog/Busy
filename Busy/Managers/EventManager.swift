//
//  EventManager.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import EventKit
import DylKit

enum EventManagerError: Error {
    case accessNotGranted
    case systemError(Error)
}


class EventManager {
    enum Defaults: String, DefaultsKey {
        var store: DefaultsStore { UserDefaults.standard }
        
        case morningEventTime = "MORNING_TIME"
        case eveningEventTime = "EVENING_TIME"
        case wholeDayEventTime = "WHOLE_DAY_TIME"
    }
    
    let store = EKEventStore()
    @UserDefaultable(key: Defaults.morningEventTime) var morningEventTime: Double = 9
    @UserDefaultable(key: Defaults.eveningEventTime) var eveningEventTime: Double = 12 + 5
    @UserDefaultable(key: Defaults.wholeDayEventTime) var wholeDayEventTime: Double = 12
    
    func requestAccess(completion: @escaping (Result<Void, EventManagerError>) -> Void) {
        store.requestAccess(to: .event) { granted, error in
            guard granted == true else {
                return completion(.failure(EventManagerError.accessNotGranted))
            }
            
            if let error = error {
                return completion(.failure(EventManagerError.systemError(error)))
            }
            
            completion(.success(()))
        }
    }
    
    func events(for date: Date) -> [Event] {
        let startDate = Calendar.autoupdatingCurrent.startOfDay(for: date)
        let endDate = Calendar.autoupdatingCurrent.date(byAdding: DateComponents(day: 1), to: startDate)!
        
        let predicate = self.store.predicateForEvents(
            withStart: startDate,
            end: endDate, calendars: nil)
        
        let events = store.events(matching: predicate)
            
        return events.filter {
            $0.isAllDay == false
        }.map {
            .init(
                id: $0.calendarItemIdentifier,
                calendarID: $0.calendar.calendarIdentifier,
                title: $0.title,
                start: $0.startDate,
                end: $0.endDate
            )
        }
    }
    
    private func calendarDisabled(for id: String) -> Bool {
        UserDefaults.standard.bool(forKey: "calendar-\(id)-disabled")
    }
    
    func calendarEnabled(for id: String) -> Bool {
        !calendarDisabled(for: id)
    }
    
    func setCalendarEnabled(_ enabled: Bool, for id: String) {
        UserDefaults.standard.set(!enabled, forKey: "calendar-\(id)-disabled")
    }
    
    func calendarSettings() -> [CalendarSetting] {
        store.calendars(for: .event).map {
            .init(
                id: $0.calendarIdentifier,
                name: $0.title,
                enabled: calendarEnabled(for: $0.calendarIdentifier)
            )
        }
    }
    
    func startTime(for period: DayPeriod) -> (hour: Int, minute: Int) {
        let offset: Double
        
        switch period {
        case .day: offset = morningEventTime
        case .night: offset = eveningEventTime
        case .wholeDay: offset = wholeDayEventTime
        }
        
        let hour = floor(offset)
        let minute = (offset - hour) * 60
        return (Int(hour), Int(minute))
    }
}
