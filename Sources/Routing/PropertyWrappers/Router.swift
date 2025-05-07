//
//  Router.swift
//
//  Created by James Sedlacek on 12/15/23.
//

import SwiftUI

/// A property-wrapper that keeps a stack of `Routable` values in `UserDefaults`
/// (via `@AppStorage`) and exposes it to SwiftUI as mutable state.
///
/// The encoded array is stored under the supplied key (default: `"RouterKey"`),
/// allowing the navigation stack to survive app launches or scene re-creation.
///
/// Basic usage:
///
/// ```swift
/// enum AppRoute: String, Routable {
///     case home, detail, settings
/// }
///
/// struct ContentView: View {
///     @Router var routes: [AppRoute] = [.home]   // stored under "RouterKey"
///
///     var body: some View { /* … */ }
/// }
///
/// // Custom key / UserDefaults instance
/// @Router("OnboardingRoutes", store: .standard)
/// var onboarding: [OnboardingRoute] = [.welcome]
/// ```
///
/// Access patterns:
/// • Read/Write: `routes.append(.detail)`
/// • Bindable:    `$routes` to drive a `NavigationStack` or similar.
///
/// - Note: Encoding/decoding uses `JSONEncoder` / `JSONDecoder`. If encoding
///   fails the `defaultValue` is returned silently.
@MainActor
@propertyWrapper
public struct Router<RouteType: Routable>: DynamicProperty {
    @AppStorage private var storage: Data
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()
    private let defaultValue: [RouteType]

    public var wrappedValue: [RouteType] {
        get {
            guard let decoded = try? decoder.decode([RouteType].self, from: storage) else {
                return defaultValue
            }
            return decoded
        }
        nonmutating set {
            guard let encoded = try? encoder.encode(newValue) else { return }
            storage = encoded
        }
    }

    public var projectedValue: Binding<[RouteType]> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    public init(
        wrappedValue: [RouteType],
        _ key: String = "RouterKey",
        store: UserDefaults? = nil
    ) {
        defaultValue = wrappedValue
        let initialData = (try? encoder.encode(wrappedValue)) ?? Data()
        _storage = .init(wrappedValue: initialData, key, store: store)
    }
}
