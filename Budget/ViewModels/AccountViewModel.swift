import Foundation

class AccountViewModel: ObservableObject {
    @Published var accounts: [Account] = []
    @Published var deposits: [Deposit] = []
    
    // Bütün hesabların cəmi balansını hesablayır
    var totalBalance: Double {
        accounts.reduce(0) { total, account in
            total + account.balance
        }
    }
    
    // Hesabın balansını yeniləyir (xərc və ya depozit)
    func updateAccountBalance(accountId: UUID, amount: Double) {
        if let account = accounts.first(where: { $0.id == accountId }) {
            account.balance += amount
            objectWillChange.send() // UI-ı yeniləmək üçün
        }
    }
    
    func addAccount(_ account: Account) {
        accounts.append(account)
    }
    
    func addDeposit(_ deposit: Deposit) {
        deposits.append(deposit)
        updateAccountBalance(accountId: deposit.accountId, amount: deposit.amount)
    }
    
    // Hesabın cari balansını qaytarır
    func getAccountBalance(for accountId: UUID) -> Double {
        if let account = accounts.first(where: { $0.id == accountId }) {
            return account.balance
        }
        return 0
    }
    
    func getTotalDeposits(for accountId: UUID) -> Double {
        deposits
            .filter { $0.accountId == accountId }
            .reduce(0) { $0 + $1.amount }
    }
} 