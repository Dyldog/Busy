//
//  DayTests.swift
//  BusyTests
//
//  Created by Dylan Elliott on 14/6/2023.
//

import XCTest
@testable import Busy

final class DayTests: XCTestCase {
    
    func testDaysAfter() throws {
        XCTAssertEqual(Day.allDays(from: .monday), [
            .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday
        ])
        
        XCTAssertEqual(Day.allDays(from: .wednesday), [
            .wednesday, .thursday, .friday, .saturday, .sunday, .monday, .tuesday,
        ])
        
        XCTAssertEqual(Day.allDays(from: .sunday), [
            .sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, 
        ])
        
        
    }
}

