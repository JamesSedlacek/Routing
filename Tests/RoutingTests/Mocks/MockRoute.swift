//
//  MockRoute.swift
//
//
//  Created by James Sedlacek on 2/10/24.
//

import Routing
import SwiftUI

enum MockRoute: Routable {
    case settings
    case profile

    var body: some View {
        switch self {
        case .settings:
            MockSettingsView()
        case .profile:
            MockProfileView()
        }
    }
}

struct MockSettingsView: View {
    var body: some View {
        Text("Mock Settings View")
    }
}

struct MockProfileView: View {
    var body: some View {
        Text("Mock Profile View")
    }
}
