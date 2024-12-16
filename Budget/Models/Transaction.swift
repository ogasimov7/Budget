import Foundation

enum TransactionType {
    case payment
    case deposit
}

struct Transaction: Identifiable {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let date: Date
    let note: String
    let category: CategorySpending? // Ödənişlər üçün
    let account: Account? // Depozitlər üçün
} 