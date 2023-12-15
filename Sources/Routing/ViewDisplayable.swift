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

public struct DisplayableView: ViewDisplayable {
    public let id: UUID = .init()
    public let viewToDisplay: AnyView

    public init<V: View>(_ viewToDisplay: V) {
        self.viewToDisplay = AnyView(viewToDisplay)
    }
}

extension DisplayableView: Equatable {
    static public func == (lhs: DisplayableView, rhs: DisplayableView) -> Bool {
        lhs.id == rhs.id
    }
}
