//
//  RoutingView.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

struct RoutingView<RootView: View>: View {
    @StateObject private var router: Router = .init()
    private let rootView: (Router) -> RootView

    init(@ViewBuilder rootView: @escaping (Router) -> RootView) {
        self.rootView = rootView
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            rootView(router)
                .navigationDestination(for: DisplayableView.self) {
                    $0.viewToDisplay
                        .environmentObject(router)
                }
        }
    }
}
