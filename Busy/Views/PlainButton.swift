//
//  PlainButton.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import SwiftUI

struct PlainButton<Content: View>: View {
    let action: () -> Void
    let label: () -> Content
    
    var body: some View {
        Button(action: action, label: label)
            .buttonStyle(PlainButtonStyle())
    }
}
