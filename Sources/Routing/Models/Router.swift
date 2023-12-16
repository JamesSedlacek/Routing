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

    @Published internal var path: NavigationPath = .init()
    @Published internal var sheet: Destination?
    @Published internal var alert: Alert?
}
