import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            // İkon və kateqoriya/hesab
            VStack(alignment: .leading, spacing: 4) {
                if let category = transaction.category {
                    Image(systemName: category.category.icon)
                        .foregroundColor(category.category.color)
                        .font(.title2)
                    Text(category.category.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else if let account = transaction.account {
                    Image(systemName: account.icon)
                        .foregroundColor(.blue)
                        .font(.title2)
                    Text(account.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 80)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.note.isEmpty ? "Əməliyyat" : transaction.note)
                    .font(.subheadline)
                Text(formatDate(transaction.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Məbləğ
            Text(transaction.type == .payment ? "-" : "+")
                .font(.headline) +
            Text("\(transaction.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(transaction.type == .payment ? .red : .green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
} 