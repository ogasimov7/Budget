//
//  BudgetApp.swift
//  Budget
//
//  Created by Orxan Qasimov on 16.12.2024.
//

import SwiftUI
import FirebaseCore

@main
struct BudgetApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
