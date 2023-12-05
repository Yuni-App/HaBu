import SwiftUI

struct ContentView: View {
    @StateObject var navigation = NavigationStateManager()
    var body: some View {
        NavigationStack(path: $navigation.path) {
            InfoView()
               
        }
        .environmentObject(navigation)
        .navigationDestination(for: PathCases.self) { path in
            AnyView(path.view)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
