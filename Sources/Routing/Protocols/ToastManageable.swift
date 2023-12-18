//
//  ToastManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

public protocol ToastManageable: ObservableObject {
    var toast: Toast? { get set }
    var isToastPresented: Binding<Bool> { get set }

    // TODO: Update to accept an `edge` parameter
    func presentToast(_ toast: Toast)
    func dismissToast()
}

extension ToastManageable {
    /// A computed property that returns a Binding<Bool> based on the presence of an Toast.
    /// The getter returns true if an Toast is present, and false otherwise.
    /// The setter sets the Toast to nil if the new value is false.
    public var isToastPresented: Binding<Bool> {
        get {
            return Binding<Bool>(
                get: { self.toast != nil },
                set: { newValue in
                    if !newValue {
                        self.toast = nil
                    }
                }
            )
        }
        set {
            if !newValue.wrappedValue {
                self.toast = nil
            }
        }
    }

    /// Presents an Toast to the user
    public func presentToast(_ toast: Toast) {
        self.toast = toast
    }

    /// Dismisses the currently presented Toast
    public func dismissToast() {
        toast = nil
    }
}
