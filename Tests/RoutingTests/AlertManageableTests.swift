//
//  AlertManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/16/23.
//

import XCTest
import SwiftUI
@testable import Routing

final class AlertManageableTests: XCTestCase {
    private var router: MockAlertManager!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPresentAlert() {
        let alert = Alert(title: Text("Title"),
                          message: Text("Message"),
                          dismissButton: .default(Text("OK")))
        router.presentAlert(alert)
        XCTAssertNotNil(router.alert)
        XCTAssertTrue(router.isAlertPresented.wrappedValue)
    }

    func testDismissAlert() {
        let alert = Alert(title: Text("Title"),
                          message: Text("Message"),
                          dismissButton: .default(Text("OK")))
        router.presentAlert(alert)
        router.dismissAlert()
        XCTAssertNil(router.alert)
        XCTAssertFalse(router.isAlertPresented.wrappedValue)
    }
}

fileprivate class MockAlertManager: AlertManageable {
    @Published var alert: Alert?
}
