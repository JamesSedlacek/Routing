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
                .sheet(item: $router.sheet) {
                    $0.viewToDisplay
                        .environmentObject(router)
                }
                .iflet(router.alert) { rootView, alert  in
                    rootView.alert(isPresented: router.isAlertPresented) {
                        alert
                    }
                }
                .iflet(router.toastConfig) { rootView, toastConfig in
                    rootView.toast(config: toastConfig,
                                   onCompletion: router.dismissToast)
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
            Button("Show Toast on top") {
                router.presentToast(on: .top, .error(message: "Network Error!"))
            }
            Button("Show Toast on bottom") {
                router.presentToast(on: .bottom,
                                    .success(message: "Toast animation works!!"), 
                                    isAutoDismissed: false)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
