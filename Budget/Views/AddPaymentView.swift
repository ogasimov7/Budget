import SwiftUI

struct AddPaymentView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var categories: [CategorySpending]
    @ObservedObject var transactionVM: TransactionViewModel
    @ObservedObject var accountVM: AccountViewModel
    
    @State private var selectedCategory: CategorySpending?
    @State private var selectedAccount: Account?
    @State private var amount = ""
    @State private var date = Date()
    @State private var note = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hesab")) {
                    if accountVM.accounts.isEmpty {
                        Text("Əvvəlcə hesab əlavə edin")
                            .foregroundColor(.gray)
                    } else {
                        Picker("Hesab seçin", selection: $selectedAccount) {
                            Text("Seçin").tag(Optional<Account>.none)
                            ForEach(accountVM.accounts) { account in
                                AccountPickerRow(account: account)
                                    .tag(Optional(account))
                            }
                        }
                    }
                }
                
                Section(header: Text("Kateqoriya")) {
                    if categories.isEmpty {
                        Text("Əvvəlcə kateqoriya əlavə edin")
                            .foregroundColor(.gray)
                    } else {
                        Picker("Kateqoriya seçin", selection: $selectedCategory) {
                            Text("Seçin").tag(Optional<CategorySpending>.none)
                            ForEach(categories) { category in
                                CategoryPickerRow(category: category)
                                    .tag(Optional(category))
                            }
                        }
                    }
                }
                
                Section(header: Text("Ödəniş məlumatları")) {
                    TextField("Məbləğ", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Tarix", selection: $date, displayedComponents: .date)
                    
                    TextField("Qeyd", text: $note)
                }
            }
            .navigationTitle("Ödəniş əlavə et")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Ləğv et") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Əlavə et") {
                        addPayment()
                    }
                    .disabled(selectedCategory == nil || selectedAccount == nil || amount.isEmpty)
                }
            }
        }
    }
    
    private func addPayment() {
        guard let category = selectedCategory,
              let account = selectedAccount,
              let amountDouble = Double(amount) else { return }
        
        // Hesabın kifayət qədər balansı olduğunu yoxlayırıq
        let currentBalance = accountVM.getAccountBalance(for: account.id)
        guard currentBalance >= amountDouble else {
            print("Hesabda kifayət qədər vəsait yoxdur")
            return
        }
        
        // Hesabdan məbləği azaldırıq
        accountVM.updateAccountBalance(accountId: account.id, amount: -amountDouble)
        
        // Kateqoriyanı yeniləyirik
        if let index = categories.firstIndex(where: { $0.id == category.id }) {
            var updatedCategory = categories[index]
            updatedCategory = CategorySpending(
                category: updatedCategory.category,
                amount: updatedCategory.amount + amountDouble
            )
            categories[index] = updatedCategory
        }
        
        // Əməliyyatı əlavə edirik
        let transaction = Transaction(
            type: .payment,
            amount: amountDouble,
            date: date,
            note: note,
            category: category,
            account: account
        )
        transactionVM.addTransaction(transaction)
        
        dismiss()
    }
}

struct CategoryPickerRow: View {
    let category: CategorySpending
    
    var body: some View {
        HStack {
            Image(systemName: category.category.icon)
                .foregroundColor(category.category.color)
            Text(category.category.rawValue)
            Spacer()
        }
    }
} 