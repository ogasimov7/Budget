import SwiftUI

struct HomeView: View {
    @ObservedObject var accountVM: AccountViewModel
    @ObservedObject var categoryVM: CategoryViewModel
    @StateObject private var transactionVM = TransactionViewModel()
    @State private var showingAddDeposit = false
    @State private var showingAddPayment = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Balance Card
                    VStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Text("Ümumi Balans")
                                .font(.subheadline)
                                .foregroundColor(Theme.secondaryText)
                            Text("$\(accountVM.totalBalance, specifier: "%.2f")")
                                .font(.system(size: 34, weight: .bold))
                        }
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Xərc limiti")
                                    .font(.subheadline)
                                    .foregroundColor(Theme.secondaryText)
                                Text("$\(transactionVM.currentMonthDeposits, specifier: "%.2f")")
                                    .font(.headline)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("İstifadə edilib")
                                    .font(.subheadline)
                                    .foregroundColor(Theme.secondaryText)
                                Text("$\(transactionVM.currentMonthSpending, specifier: "%.2f")")
                                    .font(.headline)
                            }
                        }
                    }
                    .cardStyle()
                    .padding(.horizontal)
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: { showingAddPayment = true }) {
                            VStack(spacing: 12) {
                                Circle()
                                    .fill(Color.red.opacity(0.1))
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        Image(systemName: "arrow.up.right")
                                            .foregroundColor(.red)
                                    )
                                Text("Xərc")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .cardStyle()
                        }
                        
                        Button(action: { showingAddDeposit = true }) {
                            VStack(spacing: 12) {
                                Circle()
                                    .fill(Color.green.opacity(0.1))
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundColor(.green)
                                    )
                                Text("Deposit")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .cardStyle()
                        }
                    }
                    .padding(.horizontal)
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Son Əməliyyatlar")
                                .font(.headline)
                            Spacer()
                            Button("Hamısı") {
                                // View all action
                            }
                            .foregroundColor(Theme.accent)
                        }
                        
                        if transactionVM.transactions.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "doc.text")
                                    .font(.system(size: 40))
                                    .foregroundColor(Theme.secondaryText)
                                Text("Əməliyyat yoxdur")
                                    .foregroundColor(Theme.secondaryText)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 32)
                        } else {
                            ForEach(transactionVM.transactions.prefix(5)) { transaction in
                                TransactionRow(transaction: transaction)
                                    .listRowStyle()
                            }
                        }
                    }
                    .cardStyle()
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Theme.background)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddDeposit) {
                AddDepositView(accountVM: accountVM, transactionVM: transactionVM)
            }
            .sheet(isPresented: $showingAddPayment) {
                AddPaymentView(categories: $categoryVM.categories,
                             transactionVM: transactionVM,
                             accountVM: accountVM)
            }
        }
    }
} 