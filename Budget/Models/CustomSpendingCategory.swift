import SwiftUI

struct CustomSpendingCategory: SpendingCategory, Hashable {
    let name: String
    let icon: String
    let color: Color
    
    var id: String { name }
    var rawValue: String { name }
    
    // Hashable protokolu üçün
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CustomSpendingCategory, rhs: CustomSpendingCategory) -> Bool {
        lhs.id == rhs.id
    }
} 