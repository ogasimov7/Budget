import SwiftUI

struct PersonalInfoView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var fullName: String
    @State private var showingAlert = false
    
    init(authVM: AuthViewModel) {
        self.authVM = authVM
        _fullName = State(initialValue: authVM.userProfile?.fullName ?? "")
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Ad Soyad", text: $fullName)
                Text(authVM.user?.email ?? "")
                    .foregroundColor(.secondary)
            }
            
            Section {
                Button("Məlumatları Yenilə") {
                    if !fullName.isEmpty {
                        authVM.userProfile?.fullName = fullName
                        showingAlert = true
                    }
                }
            }
        }
        .navigationTitle("Şəxsi Məlumatlar")
        .alert("Uğurlu", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Məlumatlarınız yeniləndi")
        }
    }
} 