//
//  Array+Extensions.swift
//  Busy
//
//  Created by Dylan Elliott on 14/6/2023.
//

import Foundation

extension ArraySlice {
    func array() -> [Element] {
        Array(self)
    }
}
