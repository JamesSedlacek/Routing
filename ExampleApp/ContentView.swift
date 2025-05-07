//
//  ContentView.swift
//  Routing
//
//  Created by James Sedlacek on 5/7/25.
//

import Routing
import SwiftUI

@MainActor
public struct ContentView: View {
    @Router private var router: [TestRoute] = []

    public init() {}

    public var body: some View {
        RoutingView(path: $router) {
            VStack {
                Button("Push Screen", action: pushScreenAction)
            }
        }
    }

    private func pushScreenAction() {
        router.navigate(to: .example("Hello World!"))
    }
}

#Preview {
    ContentView()
}
