//
//  Routable.swift
//
//  Created by James Sedlacek on 12/14/23.
//

import SwiftUI

/// `Routable` is a typealias that combines multiple protocols to define requirements for views that can be used within a routing system.
///
/// By conforming to `View` and `Hashable`, types that adopt `Routable` can be rendered within SwiftUI, uniquely identified, and compared for equality.
/// This is crucial for efficiently managing a navigation stack or routing mechanism in a SwiftUI application, enabling type-safe navigation between different views.
///
/// - `View`: Ensures the conforming type can be rendered in the user interface as a SwiftUI view.
/// - `Hashable`: Facilitates the unique identification of routes, which is key for handling collections of views or routes.
///
/// The `Routable` typealias is intended for use in navigation and routing systems, offering a flexible and type-safe method for defining and navigating between different views in a SwiftUI application.
///
/// Example Usage:
/// ```swift
/// enum MyRoutes: Routable {
///     case home
///     case profile(userID: UUID)
///     case settings
///
///     // Conforming to `View` by providing a computed property that returns the appropriate view for each route.
///     var body: some View {
///         switch self {
///         case .home:
///             return HomeView()
///         case .profile(let userID):
///             return ProfileView(userID: userID)
///         case .settings:
///             return SettingsView()
///         }
///     }
/// }
/// ```
public typealias Routable = View & Hashable
