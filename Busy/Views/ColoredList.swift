//
//  ColoredList.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import SwiftUI

struct ColoredList<Data, Content, BarContent>: View where Data: RandomAccessCollection, Data.Index == Int, Content: View, BarContent: View {
    let title: String
    let data: Data
    
    let colors: [Color]
    let colorOffset: Int
    
    @ViewBuilder let content: (Data.Element) -> Content
    @ViewBuilder let barContent: (() -> BarContent)?
    
    init(title: String, colors: [Color] = Color.rainbowColors, colorOffset: Int = 0, data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content, barContent: (() -> BarContent)? = nil) {
        self.title = title
        self.data = data
        self.content = content
        self.barContent = barContent
        self.colors = colors
        self.colorOffset = colorOffset
    }
    
    init(title: String, colors: [Color] = Color.rainbowColors, colorOffset: Int = 0, data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) where BarContent == AnyView {
        self.title = title
        self.data = data
        self.content = content
        self.barContent = nil
        
        self.colors = colors
        self.colorOffset = colorOffset
    }
    
    var body: some View {
        VStack(spacing: 0) {            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach((0..<data.count), id: \.self) { index in
                        content(data[index])
                            .background(colors[(index + colorOffset) % colors.count])
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
            .background(Color.black)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ZStack {
                    VStack {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.bottom)
                    }
                    
                    if let barContent = barContent {
                        HStack {
                            Spacer()
                            barContent()
                        }
                    }
                }
            }
        }
    }
}
