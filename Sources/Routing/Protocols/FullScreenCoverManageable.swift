//
//  FullScreenCoverManageable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to manage a sheet view
public protocol FullScreenCoverManageable: ObservableObject, ViewLifeCycle {
    associatedtype Destination: ViewDisplayable

    var fullScreenCover: Destination? { get set }

    func presentFullScreenCover(_ destination: Destination)
    func dismissFullScreenCover()
}

extension FullScreenCoverManageable {
    
    /// Presents a full screen cover with the specified destination
    /// - Parameter destination: The destination to present as a full screen cover
    public func presentFullScreenCover(_ destination: Destination) {
        fullScreenCover = destination
    }

    /// Dismisses the currently presented full screen cover
    public func dismissFullScreenCover() {
        fullScreenCover = nil
        callDismiss()
    }
    
    /// Presents a new sheet view
    /// - Parameters:
    ///   - destination: The view to be presented as a sheet
    ///   - onAppear: on Appear action of presented view
    ///   - onDismissed: on Disappear action of presented View
    public func presentSheet(_ destination: Destination, onAppear: CallBackHandler? = nil, onDismissed: CallBackHandler? = nil) {
        fullScreenCover = destination
        registerOnAppear(onAppear)
        registerOnDismiss(onDismissed)
    }
}
