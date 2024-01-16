//
//  RoutingView.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

public struct RoutingView<RootView: View, Routes: Routable>: View {
    @ObservedObject private var router: Router<Routes>
    private let rootView: () -> RootView
    
    public init(_ router: Router<Routes>, @ViewBuilder rootView: @escaping () -> RootView) {
        self.router = router
        self.rootView = rootView
    }

    public var body: some View {
        NavigationStack(path: $router.stack) {
            rootView()
                .navigationDestination(for: Router<Routes>.Destination.self) { route in
                    route.body.environmentObject(router)
                }
        }
    }
}
