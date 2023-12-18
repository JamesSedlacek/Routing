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
    ///   - onAppear: on Appear action of presented view
    ///   - onDismissed: on Disappear action of presented View
    public func presentSheet(_ destination: Destination, onAppear: CallBackHandler? = nil, onDismissed: CallBackHandler? = nil) {
        sheet = destination
        registerOnAppear(onAppear)
        registerOnDismiss(onDismissed)
    }
    
    /// Dismisses the currently presented sheet view
    public func dismissSheet() {
        sheet = nil
        callDismiss()
    }
}
