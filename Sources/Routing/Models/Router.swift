//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

/// `Router` is a final class that acts as the navigation manager within a SwiftUI application, leveraging the `RoutableObject` protocol to handle navigation through a stack of routable destinations.
/// It is specifically designed to work in conjunction with `RoutingView` to facilitate dynamic and type-safe navigation between views defined by the `Routes` enum.
///
/// Now conforming to `ObservableObject` and using the `@Published` property wrapper, `Router` ensures that any modifications to the navigation stack prompt automatic UI updates.
/// This enhancement is pivotal for creating responsive and state-aware navigation flows in SwiftUI applications, aligning with SwiftUI's data-driven architecture.
///
/// The class is generic over a `Routes` parameter, which must conform to the `Routable` protocol.
/// This design guarantees that the navigation stack consists solely of valid, predefined routes, enhancing the robustness and maintainability of the navigation logic.
///
/// Usage Example:
/// ```
/// @StateObject private var router: Router<MyRoutes> = .init()
///
/// var body: some View {
///     RoutingView(stack: $router.stack) {
///         MyRootView()
///     }
/// }
/// ```
///
/// In this example, `RoutingView` utilizes a `Router` instance to manage its navigation stack dynamically.
/// This setup allows for seamless navigation between the different views represented by the `MyRoutes` enum, with `Router` facilitating the navigation state management.
///
/// Properties:
/// - `stack`: A mutable array of `Routes` that signifies the current navigation stack.
/// Observing this property within SwiftUI views triggers re-renders upon its modification, enabled by the `@Published` property wrapper for dynamic and reactive navigation experiences.
///
/// Initialization:
/// - `init()`: Instantiates a `Router` with an initially empty navigation stack.
/// This base state is ready to be populated with routable destinations as dictated by the application's navigation requirements.
///
/// Conformance to `RoutableObject`:
/// - `Router` adheres to the `RoutableObject` protocol, implementing essential navigation operations such as navigating backwards, navigating to specific destinations, and managing the navigation stack.
/// These capabilities are crucial for realizing complex navigation structures in a declarative, SwiftUI-compatible manner.
public final class Router<Routes: Routable>: RoutableObject, ObservableObject {
    public typealias Destination = Routes

    @Published public var stack: [Routes] = []

    public init() {}
}
