//
//  TimesSettingView.swift
//  Busy
//
//  Created by Dylan Elliott on 21/6/2023.
//

import SwiftUI
import DylKit

enum TimeSettingsRow: CaseIterable {
    case morningEventTime
    case eveningEventTime
    case wholeDayEventTime
    
    var title: String {
        switch self {
        case .morningEventTime: return "Morning"
        case .eveningEventTime: return "Evening"
        case .wholeDayEventTime: return "Whole Day"
        }
    }
}

class TimesSettingsViewModel: ObservableObject {
    let eventManager: EventManager = .init()
    
    let stepperRange: ClosedRange<Double> = 0.0 ... 24.0
    
    func value(for row: TimeSettingsRow) -> Double {
        switch row {
        case .morningEventTime: return eventManager.morningEventTime
        case .eveningEventTime: return eventManager.eveningEventTime
        case .wholeDayEventTime: return eventManager.wholeDayEventTime
        }
    }
    
    func set(_ value: Double, for row: TimeSettingsRow) {
        objectWillChange.send()
        
        switch row {
        case .morningEventTime: eventManager.morningEventTime = value
        case .eveningEventTime: eventManager.eveningEventTime = value
        case .wholeDayEventTime: eventManager.wholeDayEventTime = value
        }
    }
    
    func displayValue(for row: TimeSettingsRow) -> String {
        let value = value(for: row)
        
        var amOrPm = "am"
        var hours = floor(value)
        let minutes = (value - hours) * 60.0
        
        if hours >= 12 {
            hours = hours - 12
            amOrPm = "pm"
        }
        
        if hours == 0 {
            hours = 12
        }
        
        let minutesString = "\(Int(minutes))".leftPadding(upTo: 2, using: "0")
        return "\(Int(hours)):\(minutesString) \(amOrPm)"
    }
}

struct TimeSettingsView: View {
    @StateObject var viewModel: TimesSettingsViewModel = .init()
    
    var body: some View {
        ColoredList(title: "Times", data: TimeSettingsRow.allCases) { row in
            HStack {
                Text("\(row.title): \(viewModel.displayValue(for: row))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Stepper(
                    "", value: .init(get: {
                        viewModel.value(for: row)
                    }, set: {
                        viewModel.set($0, for: row)
                    }), in: viewModel.stepperRange,
                    step: 0.5
                )
                .foregroundColor(.white)
                .tint(.white)
                .font(.largeTitle)
            }
            .padding()
        }
    }
}
