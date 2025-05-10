import Routing
import SwiftUI

public struct ExampleView: View {
    @Router private var router: [TestRoute] = []
    @State private var sheetRoute: SheetRoute? = nil
    private let title: String

    @MainActor
    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: 40) {
            Button("Push Screen", action: pushScreenAction)

            Text(title)

            Button("Present Sheet", action: presentSheetAction)
        }
        .sheet(item: $sheetRoute)
    }

    @MainActor
    private func pushScreenAction() {
        router.navigate(to: .lastExample)
    }

    private func presentSheetAction() {
        sheetRoute = .sheetExample("It's a whole new world!")
    }
}

public struct SheetExampleView: View {
    @State private var route: AnotherRoute? = nil
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            VStack(spacing: 40) {
                Button("Push Screen", action: pushScreenAction)
                
                Text(title)
            }
            .navigationDestination(item: $route)
        }
    }

    private func pushScreenAction() {
        route = .anotherExample("Testing")
    }
}

public struct AnotherExampleView: View {
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
    }
}

public struct LastExampleView: View {
    @Router private var router: [TestRoute] = []

    @MainActor
    public init() {}

    public var body: some View {
        Button("Navigate to Root", action: navigateToRootAction)
    }

    @MainActor
    private func navigateToRootAction() {
        router.navigateToRoot()
    }
}
