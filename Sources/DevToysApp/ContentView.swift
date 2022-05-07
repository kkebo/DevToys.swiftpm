import SwiftUI

struct ContentView {
    @State var selection: Tool?
    @State private var searchQuery = ""
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar(
                selection: self.$selection,
                searchQuery: self.searchQuery
            )
            AllToolsView(
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
            .environmentObject(AppState())
            .previewPresets()
    }
}
