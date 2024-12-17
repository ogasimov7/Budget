import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @ObservedObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Profil hissəsi
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    
                    Text(authVM.userProfile?.fullName ?? "İstifadəçi")
                        .font(.title2)
                        .bold()
                    
                    Text(authVM.user?.email ?? "")
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 20)
                
                // Ayarlar siyahısı
                List {
                    NavigationLink(destination: PersonalInfoView(authVM: authVM)) {
                        Label("Şəxsi Məlumatlar", systemImage: "person")
                    }
                    
                    NavigationLink(destination: SecuritySettingsView()) {
                        Label("Şifrə və Təhlükəsizlik", systemImage: "lock")
                    }
                    
                    NavigationLink(destination: NotificationSettingsView()) {
                        Label("Bildiriş Tənzimləmələri", systemImage: "bell")
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // Çıxış düyməsi
                Button(action: {
                    authVM.signOut()
                }) {
                    Text("Çıxış")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Profil")
        }
    }
} 