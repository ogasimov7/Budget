//
//  ContentView.swift
//  Budget
//
//  Created by Orxan Qasimov on 16.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var accountVM = AccountViewModel()
    @StateObject private var categoryVM = CategoryViewModel()
    
    var body: some View {
        TabView {
            HomeView(accountVM: accountVM, categoryVM: categoryVM)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            InsightsView(categoryVM: categoryVM)
                .tabItem {
                    Label("Kateqoriya", systemImage: "chart.pie.fill")
                }
            
            WalletView(accountVM: accountVM)
                .tabItem {
                    Label("Wallet", systemImage: "creditcard.fill")
                }
            
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
        }
    }
}

struct MoreView: View {
    var body: some View {
        Text("More View")
    }
}

#Preview {
    ContentView()
}
