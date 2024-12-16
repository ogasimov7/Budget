import SwiftUI

protocol SpendingCategory: Identifiable, Hashable {
    var id: String { get }
    var rawValue: String { get }
    var icon: String { get }
    var color: Color { get }
}

enum DefaultSpendingCategory: String, SpendingCategory {
    case utilities = "Utilities"
    case expenses = "Expenses"
    case payments = "Payments"
    case subscriptions = "Subscriptions"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .utilities: "bolt.fill"
        case .expenses: "doc.text.fill"
        case .payments: "creditcard.fill"
        case .subscriptions: "n.square.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .utilities: .orange
        case .expenses: .green
        case .payments: .blue
        case .subscriptions: .red
        }
    }
}

struct CategorySpending: Identifiable, Hashable {
    let category: any SpendingCategory
    let amount: Double
    
    var id: String { category.id }
    
    var percentage: Double {
        calculatePercentage(of: amount)
    }
    
    func calculatePercentage(of totalSpending: Double) -> Double {
        guard totalSpending > 0 else { return 0 }
        return (amount / totalSpending) * 100
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(amount)
    }
    
    static func == (lhs: CategorySpending, rhs: CategorySpending) -> Bool {
        lhs.id == rhs.id && lhs.amount == rhs.amount
    }
} 