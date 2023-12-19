//
//  Created by Ahmed Fathy on 18/12/2023.
//

import SwiftUI

public protocol Dismissable: ObservableObject {
    typealias CallBackHandler = ()-> Void
    
    var onDismiss: CallBackHandler? { get set }
}
