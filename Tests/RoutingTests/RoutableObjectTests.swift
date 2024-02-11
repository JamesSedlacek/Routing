//
//  RoutableObjectTests.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

@available(macOS 14.0, iOS 17.0, watchOS 10.0, tvOS 17.0, *)
final class RoutableObjectTests: XCTestCase {
    private var router: Router<MockRoute>!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testNavigate() {
        router.navigate(to: .settings)
        XCTAssertEqual(router.stack.count, 1)
    }

    func testNavigateMultiple() {
        router.navigate(to: [.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
    }

    func testNavigateBack() {
        router.navigate(to: .settings)
        XCTAssertEqual(router.stack.count, 1)
        router.navigateBack()
        XCTAssert(router.stack.isEmpty)
    }

    func testNavigateBackZero() {
        router.navigate(to: .settings)
        XCTAssertEqual(router.stack.count, 1)
        router.navigateBack(0)
        XCTAssertEqual(router.stack.count, 1)
    }

    func testNavigateBackNegative() {
        router.navigate(to: .settings)
        XCTAssertEqual(router.stack.count, 1)
        router.navigateBack(-1)
        XCTAssertEqual(router.stack.count, 1)
    }

    func testNavigateBackMultiple() {
        router.navigate(to: [.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
        router.navigateBack(2)
        XCTAssertEqual(router.stack.count, 1)
    }

    func testNavigateBackTooMany() {
        router.navigate(to: [.settings, .settings, .settings])
        XCTAssertEqual(router.stack.count, 3)
        router.navigateBack(4)
        XCTAssert(router.stack.isEmpty)
    }

    func testNavigateBackToRoot() {
        router.navigate(to: .settings)
        router.navigate(to: .settings)
        XCTAssertEqual(router.stack.count, 2)
        router.navigateToRoot()
        XCTAssert(router.stack.isEmpty)
    }
    
    func testNavigateBackToSpecifiedDestination() {
        router.navigate(to: [.settings, .profile, .settings, .profile, .settings])
        router.navigateBack(to: .profile)
        XCTAssertEqual(router.stack.count, 4)
        XCTAssertEqual(router.stack, [.settings, .profile, .settings, .profile])
    }

    func testNavigateBackToNonexistentDestination() {
        router.navigate(to: [.settings, .settings, .settings])
        router.navigateBack(to: .profile)
        XCTAssertEqual(router.stack.count, 3)
        XCTAssertEqual(router.stack, [.settings, .settings, .settings])
    }

    func testNavigateBackToSpecifiedDestinationWhenOnTop() {
        router.navigate(to: [.settings, .profile])
        router.navigateBack(to: .profile)
        XCTAssertEqual(router.stack.count, 2)
        XCTAssertEqual(router.stack, [.settings, .profile])
    }

    func testReplaceWithEmptyDestinations() {
        router.navigate(to: [.settings, .profile, .settings])
        router.replace(with: [])
        XCTAssert(router.stack.isEmpty)
    }

    func testReplaceWithDestinations() {
        router.navigate(to: [.settings, .settings])
        router.replace(with: [.settings, .profile, .settings])
        XCTAssertEqual(router.stack.count, 3)
        XCTAssertEqual(router.stack, [.settings, .profile, .settings])
    }
}
