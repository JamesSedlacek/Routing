//
//  ContentView.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import SwiftUI
import Routing

struct ContentView: View {
    /// Initialize each Router.
    /// One for each Tab you have.
    @StateObject private var fruitsRouter: Router<FruitsRoute> = .init()
    @StateObject private var mealsRouter: Router<MealsRoute> = .init()
    /// Store the current tab.
    /// This allows to directly open the last used tap
    /// when the app was closed.
    @AppStorage("exampleApp.currentTab") private var activeTab: Tab = .fruits
    /// Booleans indicating if the child view
    /// schould scroll to the top.
    @State var fruitsScrollToTop: Bool = false
    @State var mealsScrollToTop: Bool = false
    
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                /// Tab for displaying fruits.
                RoutingView(fruitsRouter) {
                        VStack {
                            FruitsList(scrollToTop: $fruitsScrollToTop)
                        }
                        .navigationTitle(Tab.fruits.title)
                }
                .environmentObject(fruitsRouter)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tag(Tab.fruits)
                .toolbar(.hidden, for: .tabBar)
                .tabItem {
                    Label(
                        title: { Text(Tab.fruits.title) },
                        icon: { Image(systemName: Tab.fruits.rawValue) }
                    )
                }
                /// Tab for displaying meals.
                RoutingView(mealsRouter) {
                        VStack {
                            MealsList(scrollToTop: $mealsScrollToTop)
                        }
                        .navigationTitle(Tab.meals.title)
                }
                .environmentObject(mealsRouter)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tag(Tab.meals)
                .toolbar(.hidden, for: .tabBar)
                .tabItem {
                    Label(
                        title: { Text(Tab.meals.title) },
                        icon: { Image(systemName: Tab.meals.rawValue) }
                    )
                }
            }
            
            /// A custom tabbar that can actually handle taps.
            CustomTabbar(
                activeTab: $activeTab,
                fruitsScrollToTop: $fruitsScrollToTop,
                mealsScrollToTop: $mealsScrollToTop
            )
            .environmentObject(fruitsRouter)
            .environmentObject(mealsRouter)
            .background(.bar)
            .frame(maxHeight: 50, alignment: .bottom)
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    ContentView()
}
