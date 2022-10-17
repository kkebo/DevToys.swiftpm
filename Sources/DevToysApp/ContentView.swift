import SwiftUI

struct ContentView {
    @StateObject private var state = AppState()
    @SceneStorage("selectedTool") private var selection: Tool?
    @State private var searchQuery = ""
    @State private var columnVisibility = NavigationSplitViewVisibility.all
}

extension ContentView: View {
    var body: some View {
        NavigationSplitView(columnVisibility: self.$columnVisibility) {
            Sidebar(state: self.state, selection: self.$selection, searchQuery: self.$searchQuery)
        } detail: {
            if let tool = self.selection {
                tool.page(state: self.state)
            } else {
                AllToolsView(state: self.state, searchQuery: self.$searchQuery)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onContinueUserActivity("xyz.kebo.DevToysForiPad.newWindow") {
            let payload = try? $0.typedPayload(NewWindowActivityPayload.self)
            self.selection = payload?.tool
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewPresets()
    }
}
