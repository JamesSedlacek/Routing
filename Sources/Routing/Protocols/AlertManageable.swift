//
//  AlertManageable.swift
//
//  Created by James Sedlacek on 12/16/23.
//

import SwiftUI

public protocol AlertManageable: ObservableObject {
    var alert: Alert? { get set }
    var isAlertPresented: Binding<Bool> { get set }

    func presentAlert(_ alert: Alert)
    func dismissAlert()
}

extension AlertManageable {
    /// A computed property that returns a Binding<Bool> based on the presence of an alert.
    /// The getter returns true if an alert is present, and false otherwise.
    /// The setter sets the alert to nil if the new value is false.
    public var isAlertPresented: Binding<Bool> {
        get {
            return Binding<Bool>(
                get: { self.alert != nil },
                set: { newValue in
                    if !newValue {
                        self.alert = nil
                    }
                }
            )
        }
        set {
            if !newValue.wrappedValue {
                self.alert = nil
            }
        }
    }

    /// Presents an alert to the user
    public func presentAlert(_ alert: Alert) {
        self.alert = alert
    }

    /// Dismisses the currently presented alert
    public func dismissAlert() {
        alert = nil
    }
}
