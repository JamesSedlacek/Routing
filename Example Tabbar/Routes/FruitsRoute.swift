//
//  FruitsRoute.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import Routing
import SwiftUI

enum FruitsRoute: Routable {
    case detail(String)
    
    var body: some View {
        switch self {
        case .detail(let fruit):
            FruitDetail(fruit: fruit)
        }
    }
}
