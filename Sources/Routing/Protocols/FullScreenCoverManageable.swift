//
//  FullScreenCoverManageable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to manage a sheet view
public protocol FullScreenCoverManageable: ObservableObject, Dismissable {
    associatedtype Destination: ViewDisplayable

    var fullScreenCover: Destination? { get set }
    
    func dismissFullScreenCover()
}

extension FullScreenCoverManageable {

    /// Presents a full screen cover with the specified destination
    /// - Parameters:
    ///   - destination: The view to be presented as a sheet
    ///   - onDismiss: on Disappear action of presented View
    public func presentFullScreenCover(_ destination: Destination, onDismiss: DismissAction? = nil) {
        fullScreenCover = destination
        self.onDismiss = onDismiss
    }
    
    /// Dismisses the currently presented full screen cover
    public func dismissFullScreenCover() {
        fullScreenCover = nil
        onDismiss = nil
    }
    
}
