//
//  ToastManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

public protocol ToastManageable: ObservableObject {
    var toastConfig: ToastConfiguration? { get set }

    func presentToast(on edge: VerticalEdge,
                      _ toast: Toast,
                      isAutoDismissed: Bool)
    func dismissToast()
}

extension ToastManageable {
    public func presentToast(on edge: VerticalEdge = .top,
                             _ toast: Toast,
                             isAutoDismissed: Bool = true) {
        guard toastConfig == nil else { return }
        self.toastConfig = .init(edge: edge, toast: toast, isAutoDismissed: isAutoDismissed)
    }

    public func dismissToast() {
        toastConfig = nil
    }
}
