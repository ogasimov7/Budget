import Foundation

struct Deposit: Identifiable {
    let id = UUID()
    let accountId: UUID
    let amount: Double
    let date: Date
    let note: String
} 