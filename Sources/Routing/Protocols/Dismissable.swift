//
//  Created by Ahmed Fathy on 18/12/2023.
//

import SwiftUI

public protocol Dismissable: ObservableObject {
    typealias DismissAction = ()-> Void
    
    var onDismiss: DismissAction? { get set }
}
