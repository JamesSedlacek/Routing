//
//  SheetManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

fileprivate final class SheetManageableTests: XCTestCase {
    private var router: MockSheetManager!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
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

fileprivate class MockSheetManager: SheetManageable {
    typealias Destination = Route

    @Published var sheet: Route?

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
