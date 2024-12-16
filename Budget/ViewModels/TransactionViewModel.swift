import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        transactions.sort { $0.date > $1.date }
    }
    
    // Cari ayın xərclərinin cəmini hesablayır
    var currentMonthSpending: Double {
        let calendar = Calendar.current
        let now = Date()
        
        return transactions
            .filter { transaction in
                guard transaction.type == .payment else { return false }
                return calendar.isDate(transaction.date, equalTo: now, toGranularity: .month) &&
                       calendar.isDate(transaction.date, equalTo: now, toGranularity: .year)
            }
            .reduce(0) { $0 + $1.amount }
    }
    
    // Cari ayın depozitlərinin cəmini hesablayır
    var currentMonthDeposits: Double {
        let calendar = Calendar.current
        let now = Date()
        
        return transactions
            .filter { transaction in
                guard transaction.type == .deposit else { return false }
                return calendar.isDate(transaction.date, equalTo: now, toGranularity: .month) &&
                       calendar.isDate(transaction.date, equalTo: now, toGranularity: .year)
            }
            .reduce(0) { $0 + $1.amount }
    }
} 