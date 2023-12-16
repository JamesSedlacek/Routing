//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

public final class Router<Routes: ViewDisplayable>: NavigationPathManageable,
                                                    SheetManageable,
                                                    AlertManageable {
    public typealias Destination = Routes

    @Published public var path: NavigationPath = .init()
    @Published public var sheet: Destination?
    @Published public var alert: Alert?
}
