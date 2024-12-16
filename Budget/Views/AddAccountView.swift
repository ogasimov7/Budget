import SwiftUI

struct AddAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var accountVM: AccountViewModel
    
    @State private var accountName = ""
    @State private var selectedIcon = "creditcard.fill"
    @State private var selectedCurrency: Currency = .azn
    
    private let icons = [
        "creditcard.fill",
        "banknote.fill",
        "wallet.pass.fill",
        "building.columns.fill"
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Hesab adı", text: $accountName)
                    
                    Picker("Valyuta", selection: $selectedCurrency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }
                } header: {
                    Text("Hesab məlumatları")
                }
                
                Section(header: Text("İkon")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 15) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .foregroundColor(selectedIcon == icon ? .blue : .gray)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.clear)
                                )
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Yeni Hesab")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Ləğv et") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Əlavə et") {
                        saveAccount()
                    }
                    .disabled(accountName.isEmpty)
                }
            }
        }
    }
    
    private func saveAccount() {
        let newAccount = Account(
            name: accountName,
            icon: selectedIcon,
            currency: selectedCurrency,
            initialBalance: 0
        )
        
        accountVM.addAccount(newAccount)
        dismiss()
    }
} 