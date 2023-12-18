//
//  ToastManageableTests.swift
//  
//
//  Created by James Sedlacek on 12/18/23.
//

import XCTest
import SwiftUI
@testable import Routing

final class ToastManageableTests: XCTestCase {
    private var router: MockToastManager!

    override func setUp() {
        super.setUp()
        router = .init()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testPresentToast() {
        let toast = Toast.info(message: "Test message")
        router.presentToast(toast)
        XCTAssertNotNil(router.toast)
        XCTAssertTrue(router.isToastPresented.wrappedValue)
    }

    func testDismissToast() {
        let toast = Toast.info(message: "Test message")
        router.presentToast(toast)
        router.dismissToast()
        XCTAssertNil(router.toast)
        XCTAssertFalse(router.isToastPresented.wrappedValue)
    }
}

fileprivate class MockToastManager: ToastManageable {
    @Published var toast: Toast?
}
