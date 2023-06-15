//
//  SettingsView.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import SwiftUI
import EventKit

struct CalendarSetting {
    let id: String
    let name: String
    let enabled: Bool
}

struct CalendarRow: Identifiable {
    let id: String
    let name: String
    let enabled: Bool
    let color: Color
}

class CalendarSettingsViewModel: ObservableObject {
    var calendars: [CalendarSetting] = []
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    @Published var rows: [CalendarRow] = []
    
    let eventManager: EventManager = .init()
    
    init() {
        loadCalendars()
    }
    
    private func loadCalendars() {
        calendars = eventManager.calendarSettings()
        rows = calendars.enumerated().map { index, element in
            .init(
                id: element.id,
                name: element.name,
                enabled: element.enabled,
                color: colors[index % colors.count]
            )
        }
    }
    
    func setCalendar(id: String, enabled: Bool) {
        eventManager.setCalendarEnabled(enabled, for: id)
        loadCalendars()
    }
}

struct CalendarSettingsView: View {
    @StateObject var viewModel: CalendarSettingsViewModel = .init()
    
    var body: some View {
        ColoredList(title: "Calendars", data: viewModel.rows) { row in
            Button {
                viewModel.setCalendar(id: row.id, enabled: !row.enabled)
            } label: {
                HStack {
                    Text(row.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: row.enabled ? "checkmark.square" : "square").imageScale(.large)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}
