//
//  ToastModifier.swift
//
//  Created by James Sedlacek on 12/18/23.
//

import SwiftUI

extension View {
    func toast(config: ToastConfiguration, onCompletion: @escaping () -> Void) -> some View {
        self.modifier(ToastModifier(config: config, onCompletion: onCompletion))
    }
}

struct ToastModifier: ViewModifier {
    @State private var isPresented: Bool = false
    private let config: ToastConfiguration
    private let offset: CGFloat
    private let onCompletion: () -> Void

    init(config: ToastConfiguration, onCompletion: @escaping () -> Void) {
        self.config = config
        self.onCompletion = onCompletion
        switch config.edge {
        case .top:
            self.offset = -200
        case .bottom:
            self.offset = 200
        }
    }

    func body(content: Content) -> some View {
        content
            .overlay(alignment: config.edge.alignment) {
                ToastMessageView(config.toast)
                    .offset(y: isPresented ? 0 : offset)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                dismissToastAnimation()
                            }
                    )
            }
            .onAppear {
                presentToastAnimation()
                if config.isAutoDismissed {
                    autoDismissToastAnimation()
                }
            }
    }

    private func presentToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
                isPresented = true
            }
        }
    }

    private func dismissToastAnimation() {
        withAnimation(.easeOut(duration: 0.8)) {
            isPresented = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            onCompletion()
        }
    }

    private func autoDismissToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            dismissToastAnimation()
        }
    }
}
