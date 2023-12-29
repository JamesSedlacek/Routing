//
//  Routable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

/// A type that can be used to manage a navigation stack
public protocol Routable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var stack: [Destination] { get set }

    func pop(_ count: Int)
    func pop(to destination: Destination)
    func popToRoot()
    func push(_ destination: Destination)
    func push(_ destinations: [Destination])
}

extension Routable {
    /// Pop destinations from the stack.
    /// - Parameter count: The number of destinations to pop. Default is 1.
    public func pop(_ count: Int = 1) {
        guard count <= stack.count else {
            stack = .init()
            return
        }
        stack.removeLast(count)
    }

    /// Pop destinations until the specified destination is reached.
    /// - Parameter destination: The destination to pop to.
    public func pop(to destination: Destination) {
        // Check if the destination exists in the stack
        if let index = stack.lastIndex(where: { $0 == destination }) {
            // Remove destinations above the specified destination
            stack.truncate(to: index)
        }
    }

    /// Pop all destinations, returning to the root.
    public func popToRoot() {
        stack = []
    }

    /// Push a new destination onto the stack.
    /// - Parameter destination: The destination to push.
    public func push(_ destination: Destination) {
        stack.append(destination)
    }

    /// Push a list of destinations onto the stack.
    /// - Parameter destinations: The destinations to push.
    public func push(_ destinations: [Destination]) {
        for destination in destinations {
            stack.append(destination)
        }
    }
}
