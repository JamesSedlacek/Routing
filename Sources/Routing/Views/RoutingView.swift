//
//  RoutingView.swift
//  Routing
//

import SwiftUI

/// A thin convenience wrapper around `NavigationStack` that
/// drives navigation from an external `[RouteType]` array.
///
/// `RoutingView` lets you keep the navigation “path” outside
/// of your view hierarchy (e.g. in `@AppStorage` via `@Router`)
/// while still enjoying type-safe `NavigationStack` behaviour.
/// The view creates its own `NavigationStack` under-the-hood
/// and forwards a binding to the caller-supplied `path`.
///
/// Usage:
/// ```swift
/// enum MyRoute: Routable {                // 1️⃣ Conform to Routable
///     case profile(Int)                   //    Your route cases
///
///     var body: some View {               //    Each case returns a view
///         switch self {
///         case .profile(let id):
///             ProfileView(id: id)
///         }
///     }
/// }
///
/// struct RootView: View {
///     @Router private var path: [MyRoute] = []   // 2️⃣ Persist the path
///
///     var body: some View {
///         RoutingView(path: $path) {             // 3️⃣ Wrap your root UI
///             VStack {
///                 Button("Show profile") {
///                     path.navigate(to: .profile(42))
///                 }
///             }
///         }
///     }
/// }
/// ```
///
/// - Parameters:
///   - RouteType: The enum/struct you use to describe destinations.
///                Must conform to `Routable`.
///   - RootContent: The root view shown at the bottom of the stack.
public struct RoutingView<RouteType: Routable, RootContent: View>: View {
    @Binding private var path: [RouteType]
    private let rootContent: () -> RootContent

    public init(
        path: Binding<[RouteType]>,
        @ViewBuilder rootContent: @escaping () -> RootContent
    ) {
        self._path = path
        self.rootContent = rootContent
    }

    public var body: some View {
        NavigationStack(path: $path) {
            rootContent()
                .navigationDestination(for: RouteType.self)
        }
    }
}
