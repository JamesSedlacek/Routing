//
//  FruitDetail.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI

struct FruitDetail: View {
    var fruit: String
    
    var body: some View {
        Text(fruit)
    }
}

#Preview {
    FruitDetail(fruit: "Grapes 🍇")
}
