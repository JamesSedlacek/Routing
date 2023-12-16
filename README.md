# ``Routing``

`Routing` is a framework for abstracting navigation logic from views in SwiftUI.
- Simplifies code by removing navigation responsibilities from views.
- Leads to cleaner, more manageable code.
- Promotes better separation of concerns.
- Ridiculously **lightweight** (56 executable lines of code).
- **Type-safe** routing using enums and associated values.
- 100% code coverage for protocol implementations.
- Zero 3rd party dependencies.

<br>

## Installation

You can install `Routing` using the Swift Package Manager.

1. In Xcode, select "File" > "Add Package Dependencies".
2. Copy & paste the following code into the "Search or Enter Package URL" search bar.
```
https://github.com/JamesSedlacek/Routing.git
```
4. Xcode will fetch the repository & the "Routing" library will be added to your project.

<br>

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
            
            // Example of using `presentSheet`
            Button("Present Settings View") {
                router.presentSheet(.settings)
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
