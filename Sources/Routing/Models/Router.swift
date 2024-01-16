//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

public final class Router<Routes: Routable>: RoutableObject {
    public typealias Destination = Routes

    @Published public var stack: [Routes] = []
    
    public init() {}
}
