import ExportIPAUI
import SwiftUI

struct Sidebar {
    @Environment(\.openWindow) private var openWindow
    @Bindable var state: AppState
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

@MainActor
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
        .overlay {
            if self.isSearching && self.filteredTools.isEmpty {
                ContentUnavailableView.search
            }
        }
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
        #if DEBUG
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                Section("Debug") {
                    #if TESTING_ENABLED
                        UnitTestsButton()
                    #endif
                    ExportIPAButton()
                }
            }
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
