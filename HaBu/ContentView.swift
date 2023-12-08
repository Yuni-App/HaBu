import SwiftUI

struct ContentView: View {
    @StateObject var navigation = NavigationStateManager()
    var body: some View {
            InfoView()
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
