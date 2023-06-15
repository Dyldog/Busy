//
//  URLSchemeSettingsView.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import SwiftUI
import TextView
import Combine

enum URLSchemeRows: CaseIterable {
    case field
}

class URLSchemeSettingsViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isEditing: Bool = true
    
    let schemeManager: URLSchemeManager = .init()
    var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        text = schemeManager.urlScheme
        
        $text.sink {
            self.schemeManager.urlScheme = $0
        }.store(in: &cancellables)
    }
}

struct URLSchemeSettingsView: View {
    @State var viewModel: URLSchemeSettingsViewModel = .init()
    
    var body: some View {
        ColoredList(title: "URL Scheme", colors: [.green], data: URLSchemeRows.allCases) { row in
            switch row {
            case .field:
                TextView(text: $viewModel.text, isEditing: $viewModel.isEditing, textHorizontalPadding: 8, font: .preferredFont(forTextStyle: .largeTitle), textColor: .white, autocapitalization: .none)
                    .foregroundColor(.white)
                    .frame(minHeight: 200)
                    .cornerRadius(8)
            }
        }
    }
}
