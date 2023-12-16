//
//  NavigationPathManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

fileprivate final class NavigationPathManageableTests: XCTestCase {
    var router: MockNavigationPathManager!

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
        router.push(.settings)
        XCTAssertEqual(router.path.count, 1)
        router.pop()
        XCTAssert(router.path.isEmpty)
    }

    func testPopToRoot() {
        router.push(.settings)
        router.push(.settings)
        XCTAssertEqual(router.path.count, 2)
        router.popToRoot()
        XCTAssert(router.path.isEmpty)
    }
}

fileprivate class MockNavigationPathManager: NavigationPathManageable {
    typealias Destination = Route
    @Published var path: NavigationPath = .init()

    enum Route: ViewDisplayable {
        case settings

        @ViewBuilder
        var viewToDisplay: some View {
            switch self {
            case .settings:
                MockSettingsView()
            }
        }
    }
}

fileprivate struct MockSettingsView: View {
    var body: some View {
        Text("Mock Settings View")
    }
}
