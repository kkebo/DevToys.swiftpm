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
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject private var state: AppState
    let searchQuery: String
    private let columns = [GridItem(.adaptive(minimum: 140, maximum: 160))]
}

extension AllToolsView: View {
    var body: some View {
        ToyPage {
            LazyVGrid(columns: columns) {
                ForEach(Tool.allCases) { tool in
                    let strings = tool.strings
                    if !self.isSearching
                        || self.searchQuery.isEmpty
                        || strings.localizedLongTitle.lowercased()
                            .contains(self.searchQuery.lowercased())
                    {
                        self.button(for: tool)
                    }
                }
            }
            .labelStyle(AllToolsLabelStyle())
            .foregroundStyle(.primary)
        }
        .navigationTitle(
            !self.isSearching || self.searchQuery.isEmpty
                ? "All tools"
                : "Search results"
        )
    }

    private func button(for tool: Tool) -> some View {
        let strings = tool.strings
        return NavigationLink {
            self.destination(for: tool)
        } label: {
            Label {
                Text(LocalizedStringKey(strings.longTitle))
                Text(LocalizedStringKey(strings.description))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } icon: {
                if strings.boldIcon {
                    Image(systemName: strings.iconName)
                        .font(.system(size: 50).bold())
                } else {
                    Image(systemName: strings.iconName)
                }
            }
        }
        .hoverEffect()
    }

    @ViewBuilder private func destination(for tool: Tool) -> some View {
        switch tool {
        case .base64Coder:
            Base64CoderView(state: self.state.base64CoderViewState)
        case .hashGenerator:
            HashGeneratorView(state: self.state.hashGeneratorViewState)
        case .htmlCoder:
            HTMLCoderView(state: self.state.htmlCoderViewState)
        case .jsonFormatter:
            JSONFormatterView(state: self.state.jsonFormatterViewState)
        case .jsonYAMLConverter:
            JSONYAMLConverterView()
        case .jwtDecoder:
            JWTDecoderView(state: self.state.jwtDecoderViewState)
        case .loremIpsumGenerator:
            LoremIpsumGeneratorView(
                state: self.state.loremIpsumGeneratorViewState
            )
        case .markdownPreview:
            MarkdownPreviewView(state: self.state.markdownPreviewViewState)
        case .numberBaseConverter:
            NumberBaseConverterView(
                state: self.state.numberBaseConverterViewState
            )
        case .urlCoder:
            URLCoderView(state: self.state.urlCoderViewState)
        case .uuidGenerator:
            UUIDGeneratorView(state: self.state.uuidGeneratorViewState)
        }
    }
}

struct AllToolsView_Previews: PreviewProvider {
    static var previews: some View {
        AllToolsView(searchQuery: "")
            .environmentObject(AppState())
            .previewPresets()
    }
}
