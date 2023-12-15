# ``Routing``

`Routing` is a framework for abstracting navigation logic from views in SwiftUI.
- Simplifies code by removing navigation responsibilities from views.
- Leads to cleaner, more manageable code.
- Promotes better separation of concerns.


## Router In View Example

```swift
import SwiftUI
import Routing

struct ExampleView: View {
    var body: some View {
        RoutingView { router in
    
            // Example of using `push`
            Button("Go to Detail View") {
                router.push {
                    DetailView()
                }
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

class ExampleViewModel: ObservableObject {
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func goToDetailView() {
        router.push {
            DetailView()
        }
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
        RoutingView { router in
            ExampleView(viewModel: .init(router: router))
        }
    }
}
```
