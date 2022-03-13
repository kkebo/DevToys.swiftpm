import SwiftUI

struct ContentView {}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar()
            AllToolsView(searchQuery: self.searchQuery)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
