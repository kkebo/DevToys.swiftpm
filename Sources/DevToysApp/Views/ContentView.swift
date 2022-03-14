import SwiftUI

struct ContentView {
    @State private var searchQuery = ""
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar(searchQuery: self.searchQuery)
            AllToolsView(searchQuery: self.searchQuery)
        }
        .searchable(
            text: self.$searchQuery,
            prompt: "Type to search for tools..."
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
