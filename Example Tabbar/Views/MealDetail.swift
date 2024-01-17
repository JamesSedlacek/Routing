//
//  MealDetail.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI

struct MealDetail: View {
    var meal: String
    
    var body: some View {
        Text(meal)
    }
}

#Preview {
    MealDetail(meal: "Burger 🍔")
}
