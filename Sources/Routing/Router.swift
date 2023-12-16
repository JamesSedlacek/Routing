//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

final class Router<Routes: ViewDisplayable>: Routable {
    typealias Destination = Routes

    @Published var path: NavigationPath = .init()
}
