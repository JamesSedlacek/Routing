//
//  NavigationPathManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

/// A type that can be used to manage a navigation path
public protocol NavigationPathManageable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var path: [Destination] { get set }

    func popTo(_ destination: Destination)
    func popToRoot()
    func push(_ destination: Destination)
    func push(_ destinations: [Destination])
}

extension NavigationPathManageable {
    // Function to pop the navigation stack up to a specified destination
    public func popTo(_ destination: Destination) {
         // Check if the route exists in the stack
          if let index = path.lastIndex(where: { $0 == destination }) {
              // Remove routes above the specified route
              path = Array(path.prefix(upTo: index + 1))
          }
    }

    /// Resets the navigation path to its initial state
    public func popToRoot() {
        path = []
    }

    /// Pushes a new view onto the navigation path
    /// - Parameter destination: The view to be pushed onto the navigation path
    public func push(_ destination: Destination) {
        path.append(destination)
    }

    /// Pushes multiple views onto the navigation path
    /// - Parameter destinations: The views to be pushed onto the navigation path
    public func push(_ destinations: [Destination]) {
        for destination in destinations {
            path.append(destination)
        }
    }
}
