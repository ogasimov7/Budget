import SwiftUI

struct NotificationSettingsView: View {
    @State private var dailyNotifications = true
    @State private var weeklyReports = true
    @State private var paymentReminders = true
    @State private var budgetAlerts = true
    
    var body: some View {
        Form {
            Section(header: Text("Ümumi Bildirişlər")) {
                Toggle("Gündəlik Bildirişlər", isOn: $dailyNotifications)
                Toggle("Həftəlik Hesabatlar", isOn: $weeklyReports)
            }
            
            Section(header: Text("Xəbərdarlıqlar")) {
                Toggle("Ödəniş Xatırlatmaları", isOn: $paymentReminders)
                Toggle("Büdcə Xəbərdarlıqları", isOn: $budgetAlerts)
            }
        }
        .navigationTitle("Bildiriş Tənzimləmələri")
    }
} 