import SwiftUI

struct Sidebar {
    @Environment(\.openWindow) private var openWindow
    @ObservedObject var state: AppState
    @Binding var selection: Tool?
    @Binding var searchQuery: String

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
        List(selection: self.$selection) {
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
        self.row(for: .allTools)
        ForEach(toolGroups, id: \.self) { group in
            Section(LocalizedStringKey(group.name)) {
                ForEach(group.tools) { tool in
                    self.row(for: tool)
                }
            }
        }
        #if TESTING_ENABLED
            UnitTestsButton()
        #endif
    }

    private func row(for tool: Tool) -> some View {
        let strings = tool.strings
        return NavigationLink(value: tool) {
            Label {
                Text(
                    LocalizedStringKey(
                        self.isSearching
                            ? strings.longTitle
                            : strings.shortTitle
                    )
                )
            } icon: {
                tool.icon.padding(3)
            }
        }
        .onDrag {
            let activity = NSUserActivity(activityType: "xyz.kebo.DevToysForiPad.newWindow")
            try? activity.setTypedPayload(NewWindowActivityPayload(tool: tool))
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
        NavigationStack {
            Sidebar(state: .init(), selection: .constant(nil), searchQuery: .constant(""))
        }
        .previewPresets()
    }
}
