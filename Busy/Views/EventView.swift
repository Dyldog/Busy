//
//  EventView.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import SwiftUI

struct EventView: View {
    let events: [EventRow]
    
    var body: some View {
        if events.isEmpty {
            NoEventsView()
        } else {
            VStack(alignment: .leading) {
                ForEach(events) { event in
                    HStack(alignment: .firstTextBaseline) {
                        Text(event.startTime)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text(event.title)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
