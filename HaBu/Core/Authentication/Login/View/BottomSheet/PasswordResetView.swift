import SwiftUI
import Firebase

struct PasswordResetView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            TextField("E-posta Adresi", text: $email)
                .padding()
                .foregroundColor(.blue)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Şifreyi Sıfırla") {
                resetPassword()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)

        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Bilgi"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.alertMessage = "Hata: \(error.localizedDescription)"
            } else {
                self.alertMessage = "Şifre sıfırlama bağlantısı e-posta adresinize gönderildi."
            }
            self.showAlert = true
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
