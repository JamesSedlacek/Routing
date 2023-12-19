//
//  SheetManageable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to manage a sheet view
public protocol SheetManageable: ObservableObject, ViewLifeCycle {
    associatedtype Destination: ViewDisplayable

    var sheet: Destination? { get set }

    func dismissSheet()
}

extension SheetManageable {
    /// Presents a new sheet view
    /// - Parameter destination: The view to be presented as a sheet
    public func presentSheet(_ destination: Destination) {
        sheet = destination
    }
    
    /// Presents a new sheet view
    /// - Parameters:
    ///   - destination: The view to be presented as a sheet
    ///   - CallBackHandler: on Disappear action of presented View
    public func presentSheet(_ destination: Destination, onDismiss: CallBackHandler? = nil) {
        sheet = destination
        self.onDismiss = onDismiss
    }
    
    /// Dismisses the currently presented sheet view
    public func dismissSheet() {
        sheet = nil
    }
}
