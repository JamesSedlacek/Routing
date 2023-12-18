//
//  Created by Ahmed Fathy on 18/12/2023.
//

import SwiftUI

public protocol ViewLifeCycle: ObservableObject {
    typealias CallBackHandler = ()-> Void
    
    var onAppearBlocks: [CallBackHandler?] { get set }
    var onDismissedBlocks: [CallBackHandler?] { get set }
}

public extension ViewLifeCycle {
    
    /// Top action when "onAppear" called from presented view
    var topAppearingBlock: CallBackHandler? {
        onAppearBlocks.last ?? nil
    }
    
    /// Top action when "onDisappear" called from presented view
    var topDismissedBlock: CallBackHandler? {
        onDismissedBlocks.last ?? nil
    }
    
    /// Register action of presented View for appearing
    /// - Parameter block: Action that call when "onAppear" called
    func registerOnAppear(_ block: CallBackHandler?) {
        onAppearBlocks.append(block)
    }
    
    /// Register action of presented View for dis-appearing
    /// - Parameter block: Action that call when "onAppear" called
    func registerOnDismiss(_ block: CallBackHandler?) {
        onDismissedBlocks.append(block)
    }
    
    /// Dismiss and remove action block & appearing block View is Terminated
    func callDismiss() {
        topDismissedBlock?()
        guard !onAppearBlocks.isEmpty,
                !onDismissedBlocks.isEmpty else { return }
        onAppearBlocks.removeLast()
        onDismissedBlocks.removeLast()
    }
    
    /// Call appering action block
    func callAppearing() {
        topDismissedBlock?()
    }
}
