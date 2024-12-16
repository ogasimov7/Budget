import SwiftUI

struct HomeView: View {
    @ObservedObject var accountVM: AccountViewModel
    @ObservedObject var categoryVM: CategoryViewModel
    @StateObject private var transactionVM = TransactionViewModel()
    @State private var showingAddDeposit = false
    @State private var showingAddPayment = false
    
    private var totalBalance: Double {
        accountVM.totalBalance
    }
    
    private var monthlyDeposits: Double {
        transactionVM.currentMonthDeposits
    }
    
    private var spent: Double {
        transactionVM.currentMonthSpending
    }
    
    private var spendingProgress: Double {
        guard monthlyDeposits > 0 else { return 0 }
        return min(spent / monthlyDeposits, 1.0)
    }
    
    private var progressColor: Color {
        let percentage = spendingProgress
        if percentage < 0.5 {
            return .green
        } else if percentage < 0.8 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Balans kartı
                    VStack(spacing: 20) {
                        // Balans
                        VStack(spacing: 8) {
                            Text("Ümumi Balans")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                            Text("$\(totalBalance, specifier: "%.2f")")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // Xərc limiti indikatoru
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Xərc limiti")
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundColor(.secondary)
                                    Text("$\(monthlyDeposits, specifier: "%.2f")")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("İstifadə edilib")
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundColor(.secondary)
                                    Text("$\(spent, specifier: "%.2f")")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(progressColor)
                                }
                            }
                            
                            // Progress Bar
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray6))
                                        .frame(height: 16)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(progressColor)
                                        .frame(width: geometry.size.width * spendingProgress, height: 16)
                                }
                            }
                            .frame(height: 16)
                        }
                    }
                    .padding(24)
                    .background(Color(.systemBackground))
                    .cornerRadius(24)
                    .shadow(color: Color.black.opacity(0.05), radius: 15)
                    
                    // Əməliyyat düymələri
                    HStack(spacing: 16) {
                        Button(action: { showingAddPayment = true }) {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.red.opacity(0.1))
                                        .frame(width: 56, height: 56)
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.red)
                                }
                                Text("Xərc")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 8)
                        }
                        
                        Button(action: { showingAddDeposit = true }) {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.green.opacity(0.1))
                                        .frame(width: 56, height: 56)
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.green)
                                }
                                Text("Deposit")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 8)
                        }
                    }
                    
                    // Əməliyyatlar siyahısı
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Son Əməliyyatlar")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Spacer()
                            Button("Hamısı") {
                                // View All action
                            }
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(.blue)
                        }
                        
                        if transactionVM.transactions.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "doc.text")
                                    .font(.system(size: 48))
                                    .foregroundColor(.secondary)
                                Text("Əməliyyat yoxdur")
                                    .font(.system(size: 17, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(transactionVM.transactions.prefix(5)) { transaction in
                                    TransactionRow(transaction: transaction)
                                }
                            }
                        }
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(24)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .navigationTitle("Büdcə")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
        .sheet(isPresented: $showingAddDeposit) {
            AddDepositView(accountVM: accountVM, transactionVM: transactionVM)
        }
        .sheet(isPresented: $showingAddPayment) {
            AddPaymentView(
                categories: $categoryVM.categories,
                transactionVM: transactionVM,
                accountVM: accountVM
            )
        }
    }
} 