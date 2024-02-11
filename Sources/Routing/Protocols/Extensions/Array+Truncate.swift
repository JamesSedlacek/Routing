//
//  Array+Truncate.swift
//
//  Created by James Sedlacek on 12/29/23.
//

import Foundation

extension Array {
    /// Truncates the array up to the specified index.
    ///
    /// This method mutates the original array, keeping the elements up to the given index.
    /// If the index is greater than the array's count, the array remains unchanged.
    ///
    /// - Parameter index: The index up to which the array should be truncated.
    ///
    /// Example Usage:
    /// ```
    /// var numbers = [1, 2, 3, 4, 5]
    /// numbers.truncate(to: 2)
    /// // numbers is now [1, 2, 3]
    /// ```
    mutating func truncate(to index: Int) {
        guard index < self.count && index >= 0 else {
            return
        }
        self = Array(self[..<Swift.min(index + 1, self.count)])
    }
}
