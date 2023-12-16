# ``Routing``

`Routing` is a framework for abstracting navigation logic from views in SwiftUI.
- Simplifies code by removing navigation responsibilities from views.
- Leads to cleaner, more manageable code.
- Promotes better separation of concerns.
- Ridiculously lightweight (46 executable lines of code).
- 100% code coverage for the Routable protocol.
- Zero 3rd party dependencies.

## Key Components

- **Routable:** Protocol for navigation through a set of destinations.
- **Router:** Class that manages navigation paths using types conforming to ViewDisplayable.
- **RoutingView:** SwiftUI View that uses a Router to manage navigation stacks.
- **ViewDisplayable:** Protocol for types that represent navigable views.


## Router In View Example

```swift
import SwiftUI
import Routing

enum ExampleRoute: ViewDisplayable {
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

struct ExampleView: View {
    var body: some View {
        RoutingView(ExampleRoute.self) { router in
    
            // Example of using `push`
            Button("Go to Detail View") {
                router.push(.detail)
            }
    
            // Example of using `pop`
            Button("Go back") {
                router.pop()
            }
        
            // Example of using `popToRoot`
            Button("Go back to Root") {
                router.popToRoot()
            }
        }
    }
}
```

## ViewModel Example

``` swift
import SwiftUI
import Routing

enum ExampleRoute: ViewDisplayable {
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

class ExampleViewModel: ObservableObject {
    private let router: Router<ExampleRoute>

    init(router: Router<ExampleRoute>) {
        self.router = router
    }

    func goToDetailView() {
        router.push(.detail)
    }

    func goBack() {
        router.pop()
    }

    func goBackToRoot() {
        router.popToRoot()
    }
}

struct ExampleView: View {
    @StateObject var viewModel: ExampleViewModel

    var body: some View {
        VStack {
            Button("Go to Detail View") {
                viewModel.goToDetailView()
            }

            Button("Go back") {
                viewModel.goBack()
            }

            Button("Go back to Root") {
                viewModel.goBackToRoot()
            }
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
