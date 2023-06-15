//
//  SettingsView.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import SwiftUI

enum Setting: CaseIterable {
    case calendars
    case urlScheme
    
    var title: String {
        switch self {
        case .calendars: return "Calendars"
        case .urlScheme: return "URL Scheme"
        }
    }
    
    var destination: any View {
        switch self {
        case .calendars: return CalendarSettingsView()
        case .urlScheme: return URLSchemeSettingsView()
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ColoredList(title: "Settings", data: Setting.allCases) { item in
                NavigationLink(destination: {
                    return AnyView(item.destination)
                }, label: {
                    HStack {
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right").imageScale(.large)
                            .foregroundColor(.white)
                    }
                    .padding()
                })
            }
        }
    }
}
