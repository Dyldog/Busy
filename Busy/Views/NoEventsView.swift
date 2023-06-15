//
//  NoEventsView.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import SwiftUI

struct NoEventsView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(.black.opacity(0.1))
            VStack {
                Spacer()
                
                Text("No events")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
            .cornerRadius(8)
        }
        .padding(8)
    }
}
