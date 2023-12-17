//
//  FullScreenCoverManageable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// A type that can be used to manage a sheet view
public protocol FullScreenCoverManageable: ObservableObject {
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
    }
}
