//
//  NavigationStackManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

/// A type that can be used to manage a navigation stack
public protocol NavigationStackManageable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var stack: [Destination] { get set }

    func pop(_ count: Int)
    func pop(to destination: Destination)
    func popToRoot()
    func push(_ destination: Destination)
    func push(_ destinations: [Destination])
}

extension NavigationStackManageable {
    /// Removes the specified number of destinations from the navigation stack
    /// - Parameter count: The number of views to be popped from the navigation stack
    public func pop(_ count: Int = 1) {
        guard count <= stack.count else {
            stack = .init()
            return
        }
        stack.removeLast(count)
    }
    
    // Function to pop the navigation stack up to a specified destination
       public func pop(to destination: Destination) {
            // Check if the destination exists in the stack
             if let index = stack.lastIndex(where: { $0 == destination }) {
                 // Remove destinations above the specified destination
                 stack = Array(stack.prefix(upTo: index + 1))
             }
       }

    /// Resets the navigation stack to its initial state
    public func popToRoot() {
        stack = []
    }

    /// Pushes a new view onto the navigation stack
    /// - Parameter destination: The view to be pushed onto the navigation stack
    public func push(_ destination: Destination) {
        stack.append(destination)
    }

    /// Pushes multiple views onto the navigation stack
    /// - Parameter destinations: The views to be pushed onto the navigation stack
    public func push(_ destinations: [Destination]) {
        for destination in destinations {
            stack.append(destination)
        }
    }
}
