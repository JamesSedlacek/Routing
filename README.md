<p align="center">
  <img src = "https://github.com/JamesSedlacek/Routing/blob/main/Assets/RoutingBannerArt.png">
</p>

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![GitHub stars](https://img.shields.io/github/stars/JamesSedlacek/Routing.svg)](https://github.com/JamesSedlacek/Routing/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/JamesSedlacek/Routing.svg?color=blue)](https://github.com/JamesSedlacek/Routing/network)
[![GitHub contributors](https://img.shields.io/github/contributors/JamesSedlacek/Routing.svg?color=blue)](https://github.com/JamesSedlacek/Routing/network)
<a href="https://github.com/JamesSedlacek/Routing/pulls"><img src="https://img.shields.io/github/issues-pr/JamesSedlacek/Routing" alt="Pull Requests Badge"/></a>
<a href="https://github.com/JamesSedlacek/Routing/issues"><img src="https://img.shields.io/github/issues/JamesSedlacek/Routing" alt="Issues Badge"/></a>

## Description

`Routing` is a library for abstracting navigation logic from views in SwiftUI.
- Simplifies code by removing navigation responsibilities from views.
- Leads to cleaner, more manageable code.
- Promotes better separation of concerns.
- Ridiculously **lightweight**.
- **Type-safe** routing using enums and associated values.
- Unit Tested protocol implementations.
- Zero 3rd party dependencies.

Note - This library is for **NavigationPath** only. If you need to abstract sheets, alerts, etc. then use my other library [`Presenting`](https://github.com/JamesSedlacek/Presenting)


<br>

## Requirements

- **iOS**: Requires iOS 16.0 or later.
- **macOS**: Requires macOS 13.0 or later.

<br>

## Installation

You can install `Routing` using the Swift Package Manager.

1. In Xcode, select "File" > "Add Package Dependencies".
2. Copy & paste the following into the "Search or Enter Package URL" search bar.
```
https://github.com/JamesSedlacek/Routing.git
```
4. Xcode will fetch the repository & the "Routing" library will be added to your project.

<br>

## Getting Started

1. Create the "Route" enum where views will navigate to.

``` swift
import SwiftUI
import Routing

enum Route: ViewDisplayable {
    case detail
    case settings
    
    @ViewBuilder
    var viewToDisplay: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}
```

2. The RoutingView will be used to inject the Router object into the view model. 
Pass in the Route enumeration, so that the RouterView can use the Routes. 

``` swift
import SwiftUI
import Routing

struct ContentView: View {
    var body: some View {
        RoutingView(Route.self) { router in
            ExampleView(viewModel: .init(router: router))
        }
    }
}

struct ExampleView: View {
    @ObservedObject var viewModel: ExampleViewModel
    
    var body: some View {
        // The app's main content goes here
    }
}

final class ExampleViewModel: ObservableObject {
    private let router: Router<Route>
    
    init(router: Router<Route>) {
        self.router = router
    }
}

```

3. Handle navigation using the Router functions

```swift
/// Pop destinations from the stack.
/// - Parameter count: The number of destinations to pop. Default is 1.
public func pop(_ count: Int = 1)

/// Pop destinations until the specified destination is reached.
/// - Parameter destination: The destination to pop to.
public func pop(to destination: Destination)

/// Pop all destinations, returning to the root.
public func popToRoot()

/// Push a new destination onto the stack.
/// - Parameter destination: The destination to push.
public func push(_ destination: Destination)

/// Push a list of destinations onto the stack.
/// - Parameter destinations: The destinations to push.
public func push(_ destinations: [Destination])

/// Replace the current destinations stack with the input stack.
/// - Parameter destinations: The new destinations stack.
public func replace(with destinations: [Destination])
```

<br>

## Settings Screen Example

``` swift
import SwiftUI
import Routing

enum ExampleRoute: ViewDisplayable {
    case settings
    
    @ViewBuilder
    var viewToDisplay: some View {
        switch self {
        case .settings:
            SettingsView()
        }
    }
}

class ExampleViewModel: ObservableObject {
    private let router: Router<ExampleRoute>

    init(router: Router<ExampleRoute>) {
        self.router = router
    }

    func didTapSettings() {
        router.push(.settings)
    }
}

struct ExampleView: View {
    @StateObject var viewModel: ExampleViewModel

    var body: some View {
        VStack {
            Button("Settings", action: viewModel.didTapSettings)
        }
    }
}

struct ContentView: View {
    var body: some View {
        RoutingView(ExampleRoute.self) { router in
            ExampleView(viewModel: .init(router: router))
        }
    }
}
```

## Author

James Sedlacek, find me on [X/Twitter](https://twitter.com/jsedlacekjr) or [LinkedIn](https://www.linkedin.com/in/jamessedlacekjr/)
