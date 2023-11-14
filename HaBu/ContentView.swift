import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    // LoginView ekranına geçiş yap
                    print("Login butonuna tıklandı!")
                }) {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Button(action: {
                    // RegisterView ekranına geçiş yap
                    print("Register butonuna tıklandı!")
                }) {
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Ana Ekran")
        }
    }
}

struct LoginaView: View {
    var body: some View {
        Text("LoginView")
            .navigationTitle("Login")
    }
}

struct RegisterView: View {
    var body: some View {
        Text("RegisterView")
            .navigationTitle("Register")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
