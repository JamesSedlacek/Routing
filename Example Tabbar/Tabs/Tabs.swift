//
//  Tabs.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI

/// Enumeration representing tabs in the app.
enum Tab: String, CaseIterable {
    
    /// The Fruits tab.
    case fruits = "carrot.fill"
    
    /// The Meals tab.
    case meals = "fork.knife"
    
    /// Returns the localized title for each tab.
    var title: String {
        switch self {
        case .fruits:
            return String(localized: "Fruits")
        case .meals:
            return String(localized: "Meals")
        }
    }
}
