//
//  ArrayExtensionTests.swift
//  
//
//  Created by James Sedlacek on 2/10/24.
//

import XCTest
@testable import Routing

final class ArrayExtensionTests: XCTestCase {
    func testTruncateToValidIndex() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 2)
        XCTAssertEqual(numbers, [1, 2, 3], "Array should be truncated to [1, 2, 3]")
    }

    func testTruncateToIndexBeyondCount() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 10)
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5], "Array should remain unchanged")
    }

    func testTruncateEmptyArray() {
        var emptyArray: [Int] = []
        emptyArray.truncate(to: 2)
        XCTAssertEqual(emptyArray, [], "Empty array should remain unchanged")
    }

    func testTruncateToIndexZero() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: 0)
        XCTAssertEqual(numbers, [1], "Array should be truncated to [1]")
    }

    func testTruncateWithNegativeIndex() {
        var numbers = [1, 2, 3, 4, 5]
        numbers.truncate(to: -2)
        XCTAssertEqual(numbers, [1, 2, 3, 4, 5], "Array should remain unchanged")
    }
}
