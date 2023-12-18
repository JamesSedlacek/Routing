//
//  ToastModifier.swift
//
//  Created by James Sedlacek on 12/18/23.
//

import SwiftUI

extension View {
    func toast(edge: VerticalEdge = .top, isPresented: Binding<Bool>, toast: Toast) -> some View {
        self.modifier(ToastModifier(edge: edge, isPresented: isPresented, toast: toast))
    }
}

struct ToastModifier: ViewModifier {
    let edge: VerticalEdge
    @Binding var isPresented: Bool
    let toast: Toast

    var alignment: Alignment {
        switch edge {
        case .top: .top
        case .bottom: .bottom
        }
    }

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                ToastMessageView(toast)
                // TODO: Animate using offset
            }
    }
}
