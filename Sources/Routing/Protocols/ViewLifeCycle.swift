//
//  Created by Ahmed Fathy on 18/12/2023.
//

import SwiftUI

public protocol ViewLifeCycle: ObservableObject {
    typealias CallBackHandler = ()-> Void
    
    var onDismiss: CallBackHandler? { get set }
}
