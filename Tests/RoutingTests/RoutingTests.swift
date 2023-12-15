import XCTest
import SwiftUI
@testable import Routing

final class RoutableTests: XCTestCase {
    private var router: Router!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPush() {
        router.push {
            MockView()
        }
        XCTAssertEqual(router.path.count, 1)
    }

    func testPop() {
        router.push {
            MockView()
        }
        XCTAssertEqual(router.path.count, 1)
        router.pop()
        XCTAssert(router.path.isEmpty)
    }

    func testPopToRoot() {
        router.push {
            MockView()
        }
        router.push {
            MockView()
        }
        XCTAssertEqual(router.path.count, 2)
        router.popToRoot()
        XCTAssert(router.path.isEmpty)
    }
}

struct MockView: View {
    var body: some View {
        Text("Mock View")
    }
}
