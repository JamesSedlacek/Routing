//
//  Created by Ahmed Fathy on 18/12/2023.
//

import Foundation

public protocol Dismissable: AnyObject {
    typealias DismissAction = () -> Void
    
    var onDismiss: DismissAction? { get set }
}
