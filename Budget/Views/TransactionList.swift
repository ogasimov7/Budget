import SwiftUI

struct TransactionList: View {
    let transactions: [Transaction]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
    }
} 