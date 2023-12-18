//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

public typealias Routable = NavigationPathManageable & SheetManageable & FullScreenCoverManageable & AlertManageable & ToastManageable

public final class Router<Routes: ViewDisplayable>: Routable {
    
    public var onAppearBlocks: [CallBackHandler?] = []
    public var onDismissedBlocks: [CallBackHandler?] = []
    
    public typealias Destination = Routes

    @Published public var path: NavigationPath = .init()
    @Published public var sheet: Destination?
    @Published public var fullScreenCover: Destination?
    @Published public var alert: Alert?
    @Published public var toast: Toast?
}
