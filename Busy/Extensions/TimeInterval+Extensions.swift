//
//  TimeInterval+Extensions.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation

extension TimeInterval {
    static var oneMinute: TimeInterval {
        60
    }
    
    static var oneHour: TimeInterval {
        oneMinute * 60
    }
    
    static var oneDay: TimeInterval {
        oneHour * 24
    }
    
    static var oneWeek: TimeInterval {
        oneDay * 7
    }
}
