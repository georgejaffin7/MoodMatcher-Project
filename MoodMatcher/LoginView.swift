import SwiftUI

struct LoginView: View {
    @Environment(AuthManager.self) var authManager // <-- Access the authManager from the environment

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            // Dark background
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Welcome to MoodMatcher!")
                    .font(.largeTitle)
                    .foregroundColor(.white) // White text color

                // Music symbols
                HStack(spacing: 15) {

                    Image(systemName: "music.note")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    Image(systemName: "guitars")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    Image(systemName: "music.note")
                        .foregroundColor(.white)
                        .font(.system(size: 30))

                    
                }

                // Email + password fields
                VStack {
                    TextField("Email", text: $email)
                        .foregroundColor(.white) // Text inside the field is white
                        .placeholder(when: email.isEmpty) {
                            Text("Email").foregroundColor(.gray) // Placeholder color
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Field background
                        .cornerRadius(8)

                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .placeholder(when: password.isEmpty) {
                            Text("Password").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(40)

                // Sign up + Login buttons
                HStack {
                    Button("Sign Up") {
                        print("Sign up user: \(email), \(password)")
                        authManager.signUp(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white) // Make button text white

                    Button("Login") {
                        print("Login user: \(email), \(password)")
                        authManager.signIn(email: email, password: password)
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                }
            }
        }
    }
}

// Placeholder modifier for TextField and SecureField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthManager()) // For the preview to work, pass an instance of AuthManager into the environment
}
