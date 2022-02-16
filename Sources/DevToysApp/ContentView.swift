import SwiftUI

struct ContentView {}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar()
            Text("Happy Hacking!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
