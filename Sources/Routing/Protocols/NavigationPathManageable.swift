//
//  NavigationPathManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

/// A type that can be used to manage a navigation path
public protocol NavigationPathManageable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var path: NavigationPath { get set }

    func pop()
    func popToRoot()
    func push(_ destination: Destination)
}

extension NavigationPathManageable {
    /// Removes the last destination from the navigation path
    public func pop() {
        path.removeLast()
    }

    /// Resets the navigation path to its initial state
    public func popToRoot() {
        path = .init()
    }

    /// Pushes a new view onto the navigation path
    /// - Parameter destination: The view to be pushed onto the navigation path
    public func push(_ destination: Destination) {
        path.append(destination)
    }
}
