//
//  ViewDisplayable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

public protocol ViewDisplayable: Identifiable, Hashable {
    var id: UUID { get }
    var viewToDisplay: AnyView { get }
}

extension ViewDisplayable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
