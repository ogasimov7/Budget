import SwiftUI
import FirebaseAuth

struct UserProfile {
    var fullName: String
    var email: String
}

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var errorMessage = ""
    @Published var userProfile: UserProfile?
    
    private var stateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        stateListener = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.user = user
                self.isAuthenticated = true
            }
        }
    }
    
    deinit {
        if let listener = stateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isAuthenticated = true
                self.user = result?.user
            }
        }
    }
    
    func signUp(email: String, password: String, fullName: String) {
        print("Trying to sign up with email: \(email)")
        
        guard !email.isEmpty, !password.isEmpty, !fullName.isEmpty else {
            self.errorMessage = "Bütün sahələr doldurulmalıdır"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign up error: \(error.localizedDescription)")
                print("Error details: \(error)")
                self.errorMessage = error.localizedDescription
            } else {
                print("Sign up successful")
                self.isAuthenticated = true
                self.user = result?.user
                self.userProfile = UserProfile(fullName: fullName, email: email)
                // Burada istifadəçi məlumatlarını Firestore-a da əlavə edə bilərsiniz
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
            self.user = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
} 