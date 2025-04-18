import SwiftUI

private struct AllToolsLabelStyle {
    @Environment(\.colorScheme) private var colorScheme
}

extension AllToolsLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 50))
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            self.colorScheme == .dark
                                ? Color.secondary.opacity(0.2)
                                : .clear
                        )
                )
                .padding(30)

            VStack {
                configuration.title
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
            .padding([.horizontal, .bottom])
        }
        .frame(minHeight: 300, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.secondary)
                .opacity(self.colorScheme == .dark ? 0.2 : 0.1)
        )
    }
}

struct AllToolsView {
    private static let columns = [
        GridItem(.adaptive(minimum: 140, maximum: 160))
    ]

    @Bindable var state: AppState
    @Binding var selection: Tool?
    @Binding var searchQuery: String

    private var isSearching: Bool {
        !self.searchQuery.isEmpty
    }

    private var tools: [Tool] {
        guard !self.isSearching else {
            return Tool.allCases.filter {
                $0.strings.localizedLongTitle
                    .localizedCaseInsensitiveContains(self.searchQuery)
                    || $0.strings.localizedDescription
                        .localizedCaseInsensitiveContains(self.searchQuery)
            }
        }
        return Tool.allCases
    }
}

@MainActor
extension AllToolsView: View {
    var body: some View {
        ToyPage {
            LazyVGrid(columns: Self.columns) {
                ForEach(self.tools) { tool in
                    self.button(for: tool)
                }
            }
        }
        .overlay {
            if self.tools.isEmpty {
                ContentUnavailableView.search
            }
        }
        .searchable(
            text: self.$searchQuery,
            prompt: "Type to search for tools..."
        )
        .navigationTitle(
            !self.isSearching
                ? "All tools"
                : "Search results for \"\(self.searchQuery)\""
        )
    }

    private func button(for tool: Tool) -> some View {
        Button {
            self.selection = tool
        } label: {
            self.buttonLabel(for: tool)
        }
        .tint(.primary)
        .hoverEffect()
        .onDrag {
            let activity = NSUserActivity(activityType: "xyz.kebo.DevToysForiPad.newWindow")
            try? activity.setTypedPayload(NewWindowActivityPayload(tool: tool))
            return .init(object: activity)
        } preview: {
            self.buttonLabel(for: tool)
                .frame(maxWidth: 160)
        }
        .contextMenu {
            if UIDevice.current.userInterfaceIdiom == .pad {
                OpenInNewWindowButton(tool: tool)
            }
        }
    }

    private func buttonLabel(for tool: Tool) -> some View {
        let strings = tool.strings
        return Label {
            Text(LocalizedStringKey(strings.longTitle))
            Text(LocalizedStringKey(strings.description))
                .font(.caption)
                .tint(.secondary)
        } icon: {
            tool.icon.padding(12)
        }
        .labelStyle(AllToolsLabelStyle())
    }
}

struct AllToolsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AllToolsView(state: .init(), selection: .constant(nil), searchQuery: .constant(""))
        }
        .previewPresets()
    }
}
