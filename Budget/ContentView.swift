//
//  ContentView.swift
//  Budget
//
//  Created by Orxan Qasimov on 16.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var accountVM = AccountViewModel()
    @StateObject private var categoryVM = CategoryViewModel()
    
    var body: some View {
        Group {
            if authVM.isAuthenticated {
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
                    
                    AccountView(authVM: authVM)
                        .tabItem {
                            Label("Hesab", systemImage: "person.fill")
                        }
                }
            } else {
                LoginView(authVM: authVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
