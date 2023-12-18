//
//  VerticalEdge+Extensions.swift
//
//  Created by James Sedlacek on 12/18/23.
//

import SwiftUI

extension VerticalEdge {
    var alignment: Alignment {
        switch self {
        case .top: .top
        case .bottom: .bottom
        }
    }
}
