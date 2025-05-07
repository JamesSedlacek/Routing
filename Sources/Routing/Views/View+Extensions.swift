//
//  View+Extensions.swift
//  Routing
//
//  Created by James Sedlacek on 5/6/25.
//

import SwiftUI

public extension View {
    /// Associates a destination view with a presented data type for use within a navigation stack.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `navigationDestination(for:destination:)` modifier,
    /// tailored for use with types conforming to `Routable`. The destination view is the presented `Routable` instance itself.
    ///
    /// - Parameter routeType: The type of `Routable` data that this destination binding supports.
    ///   This should be the metatype (e.g., `MyRoute.self`).
    /// - Returns: A view that has a navigation destination associated with the specified `Routable` data type.
    func navigationDestination<D: Routable>(for routeType: D.Type) -> some View {
        self.navigationDestination(for: D.self, destination: { $0 })
    }

    /// Presents a sheet when a binding to an optional `Routable` item becomes non-nil.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `sheet(item:onDismiss:content:)` modifier,
    /// tailored for use with types conforming to `Routable`. The content of the sheet is the item itself.
    ///
    /// - Parameters:
    ///   - item: A `Binding` to an optional `Routable` item. When `item` is non-nil,
    ///     the system passes the unwrapped item to the `content` closure, which then provides
    ///     the view for the sheet. If `item` becomes `nil`, the system dismisses the sheet.
    ///   - onDismiss: An optional closure that SwiftUI executes when the sheet dismisses.
    /// - Returns: A view that presents a sheet when the bound item is non-nil.
    func sheet<D: Routable & Identifiable>(item: Binding<D?>, onDismiss: (() -> Void)? = nil) -> some View {
        self.sheet(item: item, onDismiss: onDismiss, content: { $0 })
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension View {
    /// Presents a view when a binding to an optional `Routable` item becomes non-nil.
    ///
    /// This is a convenience wrapper around the standard SwiftUI `navigationDestination(item:destination:)` modifier,
    /// tailored for use with types conforming to `Routable`. The destination view is the item itself.
    ///
    /// - Parameter item: A `Binding` to an optional `Routable` item. When `item` is non-nil,
    ///   the system passes the unwrapped item to the `destination` closure, which then provides
    ///   the view to display. If `item` becomes `nil`, the system dismisses the presented view.
    /// - Returns: A view that presents another view when the bound item is non-nil.
    func navigationDestination<D: Routable>(item: Binding<D?>) -> some View {
        self.navigationDestination(item: item, destination: { $0 })
    }
}
