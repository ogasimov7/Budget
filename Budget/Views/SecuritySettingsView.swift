import SwiftUI

struct SecuritySettingsView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Şifrəni Dəyiş")) {
                SecureField("Cari Şifrə", text: $currentPassword)
                SecureField("Yeni Şifrə", text: $newPassword)
                SecureField("Yeni Şifrəni Təsdiqlə", text: $confirmPassword)
            }
            
            Section {
                Button("Şifrəni Yenilə") {
                    if newPassword == confirmPassword {
                        // Şifrə yeniləmə məntiqi
                        alertMessage = "Şifrəniz uğurla yeniləndi"
                    } else {
                        alertMessage = "Şifrələr uyğun gəlmir"
                    }
                    showingAlert = true
                }
            }
        }
        .navigationTitle("Təhlükəsizlik")
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
} 