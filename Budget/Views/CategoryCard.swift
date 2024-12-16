import SwiftUI

struct CategoryCard: View {
    let spending: CategorySpending
    let totalSpending: Double
    
    private var percentage: Int {
        Int(spending.calculatePercentage(of: totalSpending))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // İkon və məbləğ
            HStack(alignment: .top) {
                // İkon container
                ZStack {
                    Circle()
                        .fill(spending.category.color.opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: spending.category.icon)
                        .font(.system(size: 20))
                        .foregroundColor(spending.category.color)
                }
                
                Spacer()
                
                // Məbləğ
                VStack(alignment: .trailing, spacing: 4) {
                    Text("$\(spending.amount, specifier: "%.2f")")
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundColor(.primary)
                    
                    Text("\(percentage)%")
                        .font(.system(size: 13, weight: .medium, design: .default))
                        .foregroundColor(.secondary)
                }
            }
            
            // Kateqoriya adı
            Text(spending.category.rawValue)
                .font(.system(size: 15, weight: .medium, design: .default))
                .foregroundColor(.primary)
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Arxa fon
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(height: 6)
                    
                    // Progress
                    RoundedRectangle(cornerRadius: 4)
                        .fill(spending.category.color)
                        .frame(width: geometry.size.width * CGFloat(percentage) / 100, height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// AddCategoryCard-ı da yeniləyək
struct AddCategoryCard: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.blue)
                }
                
                Text("Yeni kateqoriya")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.blue)
                
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
    }
} 