import XCTest
import SwiftUI
@testable import Routing

final class RoutableTests: XCTestCase {
    private var router: MockRouter!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPush() {
        router.push(.settings)
        XCTAssertEqual(router.path.count, 1)
    }

    func testPop() {
        router.push(.profile("TestAccountId"))
        XCTAssertEqual(router.path.count, 1)
        router.pop()
        XCTAssert(router.path.isEmpty)
    }

    func testPopToRoot() {
        router.push(.settings)
        router.push(.profile("TestAccountId"))
        XCTAssertEqual(router.path.count, 2)
        router.popToRoot()
        XCTAssert(router.path.isEmpty)
    }

    func testPresentSheet() {
        router.presentSheet(.settings)
        XCTAssertNotNil(router.sheet)
    }

    func testDismissSheet() {
        router.presentSheet(.settings)
        router.dismissSheet()
        XCTAssertNil(router.sheet)
    }
}

struct MockView: View {
    var body: some View {
        Text("Mock View")
    }
}

final class MockRouter: Routable {
    typealias Destination = Routes

    @Published var path: NavigationPath = .init()
    @Published public var sheet: Destination?

    enum Routes: ViewDisplayable {
        case settings
        case profile(_ id: String)

        var id: UUID { .init() }

        @ViewBuilder
        var viewToDisplay: some View {
            switch self {
            case .settings:
                MockView()
            case .profile(_):
                MockView()
            }
        }
    }
}
