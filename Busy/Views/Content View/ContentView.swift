//
//  ContentView.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var viewModel: ContentViewModel = .init()
    
    var body: some View {
        ColoredList(title: "Busy", colorOffset: viewModel.colorOffset, data: (0..<100), content: { index in
            let row = viewModel.model(for: index)
            
            VStack(spacing: 0) {
                Text(row.name)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 3)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.1))
                
                if row.hasEvents {
                    HStack(spacing: 0) {
                        PlainButton {
                            row.onSelect(.day)
                        } label: {
                            EventView(events: row.dayEvents)
                        }
                        
                        PlainButton {
                            row.onSelect(.night)
                        } label: {
                            EventView(events: row.nightEvents)
                        }
                    }
                } else {
                    PlainButton {
                        row.onSelect(.wholeDay)
                    } label: {
                        NoEventsView()
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 100)
        }, barContent: {
            Button {
                viewModel.showSettings = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .imageScale(.large)
            }
        }).sheet(isPresented: $viewModel.showSettings) {
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
