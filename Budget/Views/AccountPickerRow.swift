import SwiftUI

struct AccountPickerRow: View {
    let account: Account
    
    var body: some View {
        HStack {
            Image(systemName: account.icon)
                .foregroundColor(.blue)
            Text(account.name)
            Spacer()
            Text(account.currency.rawValue)
                .foregroundColor(.gray)
        }
    }
} 