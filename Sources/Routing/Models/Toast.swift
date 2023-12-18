//
//  Toast.swift
//
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

public struct Toast: Identifiable {
    public let id: UUID = .init()
    let icon: Image
    let color: Color
    let message: String

    public init(icon: Image, color: Color, message: String) {
        self.icon = icon
        self.color = color
        self.message = message
    }
}

extension Toast {
    public static func debug(message: String) -> Toast {
        .init(icon: Image(.debug), color: .purple, message: message)
    }
    
    public static func error(message: String) -> Toast {
        .init(icon: Image(.error), color: .red, message: message)
    }
    
    public static func info(message: String) -> Toast {
        .init(icon: Image(.info), color: .blue, message: message)
    }
    
    public static func notice(message: String) -> Toast {
        .init(icon: Image(.notice), color: .orange, message: message)
    }
    
    public static func success(message: String) -> Toast {
        .init(icon: Image(.success), color: .green, message: message)
    }
    
    public static func warning(message: String) -> Toast {
        .init(icon: Image(.warning), color: .yellow, message: message)
    }
}
