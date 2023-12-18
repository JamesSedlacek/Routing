//
//  ToastMessageView.swift
//
//  Created by James Sedlacek on 12/17/23.
//

import SwiftUI

struct ToastMessageView: View {
    private let toast: Toast

    init(_ toast: Toast) {
        self.toast = toast
    }

    var body: some View {
        HStack(spacing: 10) {
            toast.icon
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(toast.color)
            Text(toast.message)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primary)
            Spacer(minLength: .zero)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.secondaryBackground, in: .rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .fill(toast.color.opacity(0.08))
                .stroke(toast.color, lineWidth: 2)
        }
        .padding()
    }
}

extension ToastMessageView {
    static var infoExample: some View {
        ToastMessageView(.info(message: "Something informational for the user."))
    }

    static var warningExample: some View {
        ToastMessageView(.warning(message: "Something went wrong!"))
    }

    static var errorExample: some View {
        ToastMessageView(.error(message: "Network error!"))
    }

    static var successExample: some View {
        ToastMessageView(.success(message: "Successfully did the thing!"))
    }

    static var noticeExample: some View {
        ToastMessageView(.notice(message: "A software update is available."))
    }

    static var debugExample: some View {
        ToastMessageView(.debug(message: "Line 32 in `File.swift` executed."))
    }
}

#Preview {
    VStack(spacing: 16) {
        ToastMessageView.infoExample
        ToastMessageView.warningExample
        ToastMessageView.errorExample
        ToastMessageView.successExample
        ToastMessageView.noticeExample
        ToastMessageView.debugExample
    }
}
