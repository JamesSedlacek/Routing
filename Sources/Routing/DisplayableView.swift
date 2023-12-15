//
//  DisplayableView.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

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
