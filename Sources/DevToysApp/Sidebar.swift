import SwiftUI

struct Sidebar {
    @ObservedObject var state: AppState
    @Binding var selection: Tool?
    @State private var searchQuery = ""

    private var isSearching: Bool {
        !self.searchQuery.isEmpty
    }

    private var allTools: [Tool] {
        toolGroups.flatMap(\.tools)
    }

    private var filteredTools: [Tool] {
        self.allTools.filter {
            $0.strings.localizedLongTitle
                .localizedCaseInsensitiveContains(self.searchQuery)
                || $0.strings.localizedDescription
                    .localizedCaseInsensitiveContains(self.searchQuery)
        }
    }
}

extension Sidebar: View {
    var body: some View {
        List {
            if !self.isSearching {
                self.normalRows
            } else {
                ForEach(self.filteredTools) { tool in
                    self.row(for: tool)
                }
            }
        }
        .navigationTitle("DevToys")
        .searchable(
            text: self.$searchQuery,
            prompt: "Type to search for tools..."
        )
    }

    @ViewBuilder private var normalRows: some View {
        NavigationLink {
            AllToolsView(state: self.state, selection: self.$selection)
        } label: {
            Label("All tools", systemImage: "house")
        }
        ForEach(toolGroups, id: \.self) { group in
            Section {
                ForEach(group.tools) { tool in
                    self.row(for: tool)
                }
            } header: {
                Text(LocalizedStringKey(group.name)).font(.title3.bold())
            }
        }
        #if TESTING_ENABLED
            UnitTestsButton()
        #endif
    }

    private func row(for tool: Tool) -> some View {
        let strings = tool.strings
        return NavigationLink(tag: tool, selection: self.$selection) {
            tool.page(state: self.state)
        } label: {
            Label {
                Text(
                    LocalizedStringKey(
                        self.isSearching
                            ? strings.longTitle
                            : strings.shortTitle
                    )
                )
            } icon: {
                tool.icon
            }
        }
        .onDrag {
            let activity = NSUserActivity(
                activityType: "xyz.kebo.DevToysForiPad.newWindow"
            )
            try! activity.setTypedPayload(
                NewWindowActivityPayload(tool: tool)
            )
            return .init(object: activity)
        }
        .contextMenu {
            if UIDevice.current.userInterfaceIdiom == .pad {
                OpenInNewWindowButton(tool: tool)
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Sidebar(state: .init(), selection: .constant(nil))
        }
        .previewPresets()
    }
}
