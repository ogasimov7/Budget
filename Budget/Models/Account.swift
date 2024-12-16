import Foundation

class Account: Identifiable, ObservableObject {
    let id: UUID
    let name: String
    let icon: String
    let currency: Currency
    let initialBalance: Double
    @Published var balance: Double
    
    init(id: UUID = UUID(), name: String, icon: String, currency: Currency = .azn, initialBalance: Double) {
        self.id = id
        self.name = name
        self.icon = icon
        self.currency = currency
        self.initialBalance = initialBalance
        self.balance = initialBalance
    }
}

// Hashable protokolu üçün extension
extension Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
} 