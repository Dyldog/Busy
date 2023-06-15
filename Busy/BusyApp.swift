//
//  BusyApp.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import SwiftUI

@main
struct BusyApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarColor(backgroundColor: .black)
                    .onOpenURL { url in
                        print(url.absoluteString)
                    }
            }
            .background(Color.black)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Previews_BusyApp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .navigationBarColor(backgroundColor: .black)
        }
    }
}
