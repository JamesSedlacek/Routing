//
//  FullScreenCoverManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

final class FullScreenCoverManageableTests: XCTestCase {
    private var router: MockFullScreenCoverManager!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPresentSheet() {
        router.presentFullScreenCover(.settings)
        XCTAssertNotNil(router.fullScreenCover)
    }

    func testDismissSheet() {
        router.presentFullScreenCover(.settings)
        router.dismissFullScreenCover()
        XCTAssertNil(router.fullScreenCover)
    }
    
    func test_present_onDismissingAction() {
        
        var dismissedCallCounter: Int = 0
        let exp = expectation(description: "Wait until view dismissable")
        
        router.presentFullScreenCover(.settings, onDismissed: {
            dismissedCallCounter += 1
            exp.fulfill()
        })
        
        XCTAssertEqual(router.onDismissedBlocks.count, 1)
        
        router.dismissFullScreenCover()
        
        wait(for: [exp], timeout: 0.5)
        
        XCTAssertNil(router.fullScreenCover)
        XCTAssertEqual(dismissedCallCounter, 1)
    }
}

fileprivate class MockFullScreenCoverManager: FullScreenCoverManageable {
    
    typealias Destination = Route
    
    var onAppearBlocks: [CallBackHandler?] = []
    var onDismissedBlocks: [CallBackHandler?] = []

    @Published var fullScreenCover: Route?

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
