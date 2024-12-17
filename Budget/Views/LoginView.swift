import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var isSignUp = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(isSignUp ? "Hesab Yarat" : "Daxil Ol")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 50)
                
                VStack(spacing: 15) {
                    if isSignUp {
                        TextField("Ad Soyad", text: $fullName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Şifrə", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                if !authVM.errorMessage.isEmpty {
                    Text(authVM.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    if isSignUp {
                        authVM.signUp(email: email, password: password, fullName: fullName)
                    } else {
                        authVM.signIn(email: email, password: password)
                    }
                }) {
                    Text(isSignUp ? "Qeydiyyatdan keç" : "Daxil ol")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Hesabınız var? Daxil olun" : "Hesabınız yoxdur? Qeydiyyatdan keçin")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
        }
    }
} 