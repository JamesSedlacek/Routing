//
//  MealsList.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI
import Routing

struct MealsList: View {
    /// The router for the fruits.
    @EnvironmentObject var mealsRouter: Router<MealsRoute>
    /// Binding checking if the list should scroll to the top
    @Binding var scrollToTop: Bool
    
    var body: some View {
        ScrollViewReader { scrollviewReader in
            List {
                /// Enumerated loop to assign the index to an item.
                /// This way you can determine which element is
                /// the first in the list.
                ForEach(Array(mealsWithEmojis.enumerated()), id: \.offset) { index, meal in
                    Button(action: {
                        /// Navigate to the detail view
                        mealsRouter.navigate(to: .detail(meal))
                    }, label: {
                        Text(meal)
                    })
                    .id(index)
                }
            }
            .onChange(of: scrollToTop) {
                withAnimation {
                    /// Scroll to the first index of the list
                    scrollviewReader.scrollTo(0)
                }
            }
        }
    }
}

#Preview {
    MealsList(scrollToTop: .constant(false))
}
