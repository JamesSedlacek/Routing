//
//  CustomTabbar.swift
//  RoutingExample
//
//  Created by Timo Eichelmann on 17.01.24.
//

import Foundation
import SwiftUI
import Routing

struct CustomTabbar: View {
    /// Environment Values
    @EnvironmentObject var fruitsRouter: Router<FruitsRoute>
    @EnvironmentObject var mealsRouter: Router<MealsRoute>
    
    /// View Properties
    @Binding var activeTab: Tab
    
    /// Binding for toggling the scroll to top action.
    @Binding var fruitsScrollToTop: Bool
    @Binding var mealsScrollToTop: Bool
    
    /// State variable indicating whether the tab bar bounces down.
    @State private var bouncesDown: Bool = true
    
    var body: some View {
        CustomTabBar()
    }
    
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { animatedTab in
                let tab = animatedTab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    handleTabTap(tab: tab)
                }
            }
        }
    }
    
    /// Handles the tap action on a tab within the TabView.
    /// - Parameter tab: The tapped tab.
    private func handleTabTap(tab: Tab) {
        if activeTab == tab {
            switch activeTab {
            case .fruits:
                // Reset Navigation for Components tab
                if fruitsRouter.stack.isEmpty {
                    fruitsScrollToTop.toggle()
                } else {
                    fruitsRouter.navigateToRoot()
                }
            case .meals:
                // Reset Navigation for Repositories tab
                if mealsRouter.stack.isEmpty {
                    mealsScrollToTop.toggle()
                } else {
                    mealsRouter.navigateToRoot()
                }
            }
        } else {
            // Switch to the tapped tab
            activeTab = tab
        }
    }

}
