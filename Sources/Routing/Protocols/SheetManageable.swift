//
//  SheetManageable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to manage a sheet view
internal protocol SheetManageable: ObservableObject {
    associatedtype Destination: ViewDisplayable

    var sheet: Destination? { get set }

    func presentSheet(_ destination: Destination)
    func dismissSheet()
}

extension SheetManageable {
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
