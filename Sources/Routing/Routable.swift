//
//  Routable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to navigate through a set of destinations
public protocol Routable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var path: NavigationPath { get set }
    var sheet: Destination? { get set }

    func pop()
    func popToRoot()
    func push(_ destination: Destination)
    func presentSheet(_ destination: Destination)
    func dismissSheet()
}

extension Routable {
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

    /// Presents a new sheet view
    /// - Parameter destination: The view to be presented as a sheet
    public func presentSheet(_ destination: Destination) {
        sheet = destination
    }

    /// Dismisses the currently presented sheet view
    public func dismissSheet() {
        sheet = nil
    }
}
