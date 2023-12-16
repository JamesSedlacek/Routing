//
//  View+Extensions.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

internal extension View {
    /// Closure given view and unwrapped optional value if optional is set.
    /// - Parameters:
    ///   - conditional: Optional value.
    ///   - content: Closure to run on view with unwrapped optional.
    @ViewBuilder func iflet<Content: View, T>(_ conditional: Optional<T>, @ViewBuilder _ content: (Self, _ value: T) -> Content) -> some View {
        if let value = conditional {
            content(self, value)
        } else {
            self
        }
    }
}
