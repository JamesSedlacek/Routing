//
//  RoutingView.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

public struct RoutingView<RootView: View, Routes: ViewDisplayable>: View {
    @StateObject private var router: Router<Routes> = .init()
    private let rootView: (Router<Routes>) -> RootView

    public init(_ routeType: Routes.Type, @ViewBuilder rootView: @escaping (Router<Routes>) -> RootView) {
        self.rootView = rootView
    }

    public var body: some View {
        NavigationStack(path: $router.path) {
            rootView(router)
                .navigationDestination(for: Router<Routes>.Destination.self) {
                    $0.viewToDisplay
                        .environmentObject(router)
                }
                .sheet(item: $router.sheet, onDismiss: router.onDismiss) {
                    $0.viewToDisplay
                        .environmentObject(router)
                }
                .iflet(router.alert) { rootView, alert  in
                    rootView.alert(isPresented: router.isAlertPresented) {
                        alert
                    }
                }
                .iflet(router.toast) { rootView, toast in
                    rootView.toast(isPresented: router.isToastPresented, toast: toast)
                }
#if !os(macOS)
                .fullScreenCover(item: $router.fullScreenCover) {
                    $0.viewToDisplay
                        .environmentObject(router)
                }
#endif
        }
    }
}

#Preview {
    enum Routes: ViewDisplayable {
        case settings

        @ViewBuilder
        var viewToDisplay: some View {
            switch self {
            case .settings: EmptyView()
            }
        }
    }

    return RoutingView(Routes.self) { router in
        VStack(spacing: 40) {
            Spacer()
            Button("Show Toast") {
                router.presentToast(.notice(message: "A software update is available."))
            }
            Button("Dismiss Toast") {
                router.dismissToast()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
