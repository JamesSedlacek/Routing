//
//  RoutableObject.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

/// RoutableObject protocol defines the basic navigation operations for a routable object.
public protocol RoutableObject: ObservableObject {
    associatedtype Destination: Routable

    /// The navigation stack, represented as an array of destinations.
    var stack: [Destination] { get set }

    /// Navigate back in the stack by a specified count.
    func navigateBack(_ count: Int)
    
    /// Navigate back to a specific destination in the stack.
    func navigateBack(to destination: Destination)
    
    /// Navigate to the root of the stack by emptying it.
    func navigateToRoot()
    
    /// Navigate to a specific destination by appending it to the stack.
    func navigate(to destination: Destination)
    
    /// Navigate to multiple destinations by appending them to the stack.
    func navigate(to destinations: [Destination])
    
    /// Replace the current stack with new destinations.
    func replace(with destinations: [Destination])
}

extension RoutableObject {
    /// Navigate back in the stack by a specified count
    /// If the count is greater than the stack count, the stack is emptied
    public func navigateBack(_ count: Int = 1) {
        guard count > 0 else { return }
        guard count <= stack.count else {
            stack = .init()
            return
        }
        stack.removeLast(count)
    }

    /// Navigate back to a specific destination in the stack
    /// If the destination exists in the stack, all destinations above it are removed
    public func navigateBack(to destination: Destination) {
        // Check if the destination exists in the stack
        if let index = stack.lastIndex(where: { $0 == destination }) {
            // Remove destinations above the specified destination
            stack.truncate(to: index)
        }
    }

    /// Navigate to the root of the stack by emptying it
    public func navigateToRoot() {
        stack = []
    }

    /// Navigate to a specific destination by appending it to the stack
    public func navigate(to destination: Destination) {
        stack.append(destination)
    }

    /// Navigate to multiple destinations by appending them to the stack
    public func navigate(to destinations: [Destination]) {
        for destination in destinations {
            stack.append(destination)
        }
    }

    /// Replace the current stack with a new set of destinations
    public func replace(with destinations: [Destination]) {
        stack = destinations
    }
}
