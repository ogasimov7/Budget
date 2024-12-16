import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategorySpending] = []
    
    func addCategory(_ category: CategorySpending) {
        categories.append(category)
    }
    
    func updateCategory(_ category: CategorySpending) {
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            categories[index] = category
        }
    }
} 