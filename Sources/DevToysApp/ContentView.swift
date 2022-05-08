import SwiftUI

struct ContentView {
    @StateObject private var state = AppState()
    @State var selection: Tool?
    @State private var searchQuery = ""
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar(
                state: self.state,
                selection: self.$selection,
                searchQuery: self.searchQuery
            )
            AllToolsView(
                state: self.state,
                selection: self.$selection,
                searchQuery: self.searchQuery
            )
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
            .previewPresets()
    }
}
