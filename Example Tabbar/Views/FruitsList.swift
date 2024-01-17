//
//  FruitsList.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI
import Routing

struct FruitsList: View {
    /// The router for the fruits.
    @EnvironmentObject var fruitsRouter: Router<FruitsRoute>
    /// Binding checking if the list should scroll to the top
    @Binding var scrollToTop: Bool
    
    var body: some View {
        ScrollViewReader { scrollviewReader in
            List {
                /// Enumerated loop to assign the index to an item.
                /// This way you can determine which element is
                /// the first in the list.
                ForEach(Array(fruitsWithEmojis.enumerated()), id: \.offset) { index, fruit in
                    Button(action: {
                        /// Navigate to the detail view
                        fruitsRouter.navigate(to: .detail(fruit))
                    }, label: {
                        Text(fruit)
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
    FruitsList(scrollToTop: .constant(false))
}
