//
//  RoutableTests.swift
//
//  Created by James Sedlacek on 12/16/23.
//

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
        XCTAssertEqual(router.stack.count, 1)
    }

    func testPushMultiple() {
        router.push([.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
    }

    func testPop() {
        router.push(.settings)
        XCTAssertEqual(router.stack.count, 1)
        router.pop()
        XCTAssert(router.stack.isEmpty)
    }

    func testPopMultiple() {
        router.push([.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
        router.pop(2)
        XCTAssertEqual(router.stack.count, 1)
    }

    func testPopTooMany() {
        router.push([.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
        router.pop(4)
        XCTAssert(router.stack.isEmpty)
    }

    func testPopToRoot() {
        router.push(.settings)
        router.push(.settings)
        XCTAssertEqual(router.stack.count, 2)
        router.popToRoot()
        XCTAssert(router.stack.isEmpty)
    }
    
    func testPopToSpecifiedDestination() {
        router.push([.settings, .profile, .settings, .profile, .settings])
        router.pop(to: .profile)
        XCTAssertEqual(router.stack.count, 4)
        XCTAssertEqual(router.stack, [.settings, .profile, .settings, .profile])
    }

    func testPopToNonexistentDestination() {
        router.push([.settings, .settings, .settings])
        router.pop(to: .profile)
        XCTAssertEqual(router.stack.count, 3)
        XCTAssertEqual(router.stack, [.settings, .settings, .settings])
    }

    func testPopToSpecifiedDestinationWhenOnTop() {
        router.push([.settings, .profile])
        router.pop(to: .profile)
        XCTAssertEqual(router.stack.count, 2)
        XCTAssertEqual(router.stack, [.settings, .profile])
    }
}

fileprivate class MockRouter: Routable {
    typealias Destination = Route
    @Published var stack: [Route] = []

    enum Route: ViewDisplayable {
        case settings, profile

        @ViewBuilder
        var viewToDisplay: some View {
            switch self {
            case .settings:
                MockSettingsView()
            case .profile:
                MockProfileView()
            }
        }
    }
}

fileprivate struct MockSettingsView: View {
    var body: some View {
        Text("Mock Settings View")
    }
}

fileprivate struct MockProfileView: View {
    var body: some View {
        Text("Mock Profile View")
    }
}
