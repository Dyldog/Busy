//
//  String+IntValue.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import Foundation

extension String {
    var intValue: Int? {
        Int(self)
    }
    
    var doubleValue: Double? {
        Double(self)
    }
}
