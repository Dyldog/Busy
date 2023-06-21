//
//  String+Padding.swift
//  Busy
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

extension RangeReplaceableCollection where Self: StringProtocol {
    func leftPadding(upTo length: Int, using element: Element = " ") -> SubSequence {
        return repeatElement(element, count: Swift.max(0, length-count)) + suffix(Swift.max(count, count-length))
    }
}
