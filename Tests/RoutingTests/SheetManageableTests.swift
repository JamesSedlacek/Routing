//
//  SheetManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

final class SheetManageableTests: XCTestCase {
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
    
    func test_present_onDismissingAction() {
        
        var dismissedCallCounter: Int = 0
        let exp = expectation(description: "Wait until view dismissable")
        
        router.presentSheet(.settings, onDismissed: {
            dismissedCallCounter += 1
            exp.fulfill()
        })
        
        XCTAssertEqual(router.onDismissedBlocks.count, 1)
        
        router.dismissSheet()
        
        wait(for: [exp], timeout: 0.5)
        
        XCTAssertNil(router.sheet)
        XCTAssertEqual(dismissedCallCounter, 1)
    }    
}

fileprivate class MockSheetManager: SheetManageable {
    
    var onAppearBlocks: [CallBackHandler?] = []
    var onDismissedBlocks: [CallBackHandler?] = []
    
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
