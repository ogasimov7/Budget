import SwiftUI

struct WalletView: View {
    @ObservedObject var accountVM: AccountViewModel
    @State private var showingAddAccount = false
    
    var body: some View {
        NavigationView {
            Group {
                if accountVM.accounts.isEmpty {
                    // Boş vəziyyət
                    VStack(spacing: 16) {
                        Image(systemName: "creditcard.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)
                        Text("Hesab əlavə edin")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.secondary)
                        Button(action: {
                            showingAddAccount = true
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "plus")
                                Text("Hesab əlavə et")
                            }
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(minWidth: 200)
                            .background(Color.primary)
                            .cornerRadius(12)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
                } else {
                    // Hesablar siyahısı
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(accountVM.accounts) { account in
                                AccountRow(account: account, accountVM: accountVM)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Hesablar")
                    .navigationBarItems(
                        trailing: Button(action: {
                            showingAddAccount = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                    )
                    .background(Color(.systemGroupedBackground))
                }
            }
        }
        .sheet(isPresented: $showingAddAccount) {
            AddAccountView(accountVM: accountVM)
        }
    }
} 