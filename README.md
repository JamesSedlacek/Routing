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

`Routing` is a **lightweight** SwiftUI navigation library.
- Leverages 1st-party APIs `NavigationStack` & `NavigationDestination`.
- Never be confused about `NavigationLink` or `NavigationPath` again! (You don't need them)
- Type-Safe Navigation (better performance than type-erasing).
- Centralized Navigation Logic.
- Dynamic Navigation Stack Management.
- Unit Tested protocol implementations.
- Zero 3rd party dependencies.
- [Documentation](https://jamessedlacek.github.io/documentation/routing)

Note - This library is for **NavigationStack** only. <br>
If you need to abstract sheets, alerts, etc. then use my other library [`Presenting`](https://github.com/JamesSedlacek/Presenting)

<br>

## Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
3. [Getting Started](#getting-started)
4. [Passing Data Example](#passing-data-example)
5. [Under the hood](#under-the-hood)
6. [Author](#author)

<br>

## Requirements

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 16.0            |
| macOS    | 13.0            |
| tvOS     | 16.0            |
| watchOS  | 9.0             |

<br>

## Installation

You can install `Routing` using the Swift Package Manager.

1. In Xcode, select `File` > `Add Package Dependencies`.
<p align="left">
  <img src = "https://github.com/JamesSedlacek/Routing/blob/main/Assets/Installation1.png" width="350">
</p>
<br>

2. Copy & paste the following into the `Search or Enter Package URL` search bar.
```
https://github.com/JamesSedlacek/Routing.git
```

<p align="left">
  <img src = "https://github.com/JamesSedlacek/Routing/blob/main/Assets/Installation2.png" width="350">
</p>
<br>

3. Xcode will fetch the repository & the `Routing` library will be added to your project.

<br>

## Getting Started

1. Create a `Route` enum that conforms to the `Routable` protocol.

``` swift
import Routing
import SwiftUI

enum ExampleRoute: Routable {
    case detail
    case settings
    
    var body: some View {
        switch self {
        case .detail:
            DetailView()
        case .settings:
            SettingsView()
        }
    }
}
```

2. Create a `Router` object and wrap your `RootView` with a `RoutingView`.

``` swift
import SwiftUI
import Routing

struct ContentView: View {
    @Bindable private var router: Router<ExampleRoute> = .init()

    var body: some View {
        RoutingView(stack: $router.stack) {
            Button("Go to Settings") {
                router.navigate(to: .settings)
            }
        }
    }
}
```

3. Handle navigation using the `Router` functions

```swift
/// Navigate back in the stack by a specified count.
func navigateBack(_ count: Int)

/// Navigate back to a specific destination in the stack.
func navigateBack(to destination: Destination)

/// Navigate to the root of the stack by emptying it.
func navigateToRoot()

/// Navigate to a specific destination by appending it to the stack.
func navigate(to destination: Destination)

/// Navigate to multiple destinations by appending them to the stack.
func navigate(to destinations: [Destination])

/// Replace the current stack with new destinations.
func replace(with destinations: [Destination])
```

<br>

## Passing Data Example

```swift
import Routing
import SwiftUI

enum ContentRoute: Routable {
    case detail(Color)
    case settings

    var body: some View {
        switch self {
        case .detail(let color):
            ColorDetail(color: color)
        case .settings:
            SettingsView()
        }
    }
}

struct ContentView: View {
    @Bindable private var router: Router<ContentRoute> = .init()
    private let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        RoutingView(stack: $router.stack) {
            List(colors, id: \.self) { color in
                color
                    .onTapGesture {
                        router.navigate(to: .detail(color))
                    }
            }
        }
    }
}

struct ColorDetail: View {
    private let color: Color

    init(color: Color) {
        self.color = color
    }

    var body: some View {
        color.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

<br>

## Under the hood

The `RoutingView` essentially is just wrapping your view with a `NavigationStack` & `navigationDestination`.
``` swift
NavigationStack(path: $routes) {
    root()
        .navigationDestination(for: Routes.self) { view in
            view.body
        }
}
```

## Author

James Sedlacek, find me on [X/Twitter](https://twitter.com/jsedlacekjr) or [LinkedIn](https://www.linkedin.com/in/jamessedlacekjr/)
