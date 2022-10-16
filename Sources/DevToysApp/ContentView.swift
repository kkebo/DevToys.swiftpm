import SwiftUI

struct ContentView {
    @StateObject private var state = AppState()
    @SceneStorage("selectedTool") private var selection: Tool?
    @State private var searchQuery = ""
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar(state: self.state, selection: self.$selection, searchQuery: self.$searchQuery)
            if let tool = self.selection {
                // If the sidebar is collapsed from the beginning, the transition using NavigationLink's selection doesn't fire until the sidebar is shown once. The following code is a workaround for that.
                tool.page(state: self.state)
            } else {
                AllToolsView(state: self.state, selection: self.$selection, searchQuery: self.$searchQuery)
            }
        }
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
