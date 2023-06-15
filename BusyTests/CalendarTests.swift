//
//  CalendarTests.swift
//  BusyTests
//
//  Created by Dylan Elliott on 14/6/2023.
//

import XCTest
@testable import Busy

final class CalendarTests: XCTestCase {
    func testWeekdayIndex() {
        let date = Calendar.autoupdatingCurrent.date(day: 14, month: 6, year: 2023)
        XCTAssertEqual(Calendar.autoupdatingCurrent.weekdayIndex(of: date), 2)
    }
}
