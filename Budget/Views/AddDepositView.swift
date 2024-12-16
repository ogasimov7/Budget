import SwiftUI

struct AddDepositView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var accountVM: AccountViewModel
    @ObservedObject var transactionVM: TransactionViewModel
    
    @State private var selectedAccount: Account?
    @State private var amount = ""
    @State private var date = Date()
    @State private var note = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hesab")) {
                    Picker("Hesab seçin", selection: $selectedAccount) {
                        ForEach(accountVM.accounts) { account in
                            AccountPickerRow(account: account)
                                .tag(account as Account?)
                        }
                    }
                }
                
                Section(header: Text("Depozit məlumatları")) {
                    TextField("Məbləğ", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Tarix", selection: $date, displayedComponents: .date)
                    
                    TextField("Qeyd", text: $note)
                }
            }
            .navigationTitle("Depozit əlavə et")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Ləğv et") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Əlavə et") {
                        addDeposit()
                    }
                    .disabled(selectedAccount == nil || amount.isEmpty)
                }
            }
        }
    }
    
    private func addDeposit() {
        guard let account = selectedAccount,
              let amountDouble = Double(amount) else { return }
        
        let deposit = Deposit(accountId: account.id, amount: amountDouble, date: date, note: note)
        accountVM.addDeposit(deposit)
        
        let transaction = Transaction(
            type: .deposit,
            amount: amountDouble,
            date: date,
            note: note,
            category: nil,
            account: account
        )
        transactionVM.addTransaction(transaction)
        
        dismiss()
    }
}

#Preview {
    AddDepositView(accountVM: AccountViewModel(), transactionVM: TransactionViewModel())
} 