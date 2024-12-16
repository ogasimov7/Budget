import SwiftUI

struct AccountRow: View {
    let account: Account
    @ObservedObject var accountVM: AccountViewModel
    
    var body: some View {
        HStack {
            Image(systemName: account.icon)
                .foregroundColor(.blue)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(account.name)
                    .font(.headline)
                
                Text("Son depozitlər:")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let lastDeposit = accountVM.deposits
                    .filter({ $0.accountId == account.id })
                    .sorted(by: { $0.date > $1.date })
                    .first {
                    Text("\(lastDeposit.date.formatted(date: .numeric, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text("\(account.balance, specifier: "%.2f")")
                .font(.headline) +
            Text(" \(account.currency.rawValue)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
} 