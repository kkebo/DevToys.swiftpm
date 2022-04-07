import SwiftUI

struct Sidebar {
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject private var state: AppState
    let searchQuery: String

    private func isMatch(_ name: String) -> Bool {
        self.searchQuery.isEmpty
            || name.lowercased().contains(self.searchQuery.lowercased())
    }
}

extension Sidebar: View {
    var body: some View {
        List {
            if !self.isSearching || self.searchQuery.isEmpty {
                self.normalRows
            } else {
                self.searchResults
            }
        }
        .navigationTitle("DevToys")
    }

    @ViewBuilder private var normalRows: some View {
        NavigationLink {
            AllToolsView(searchQuery: self.searchQuery)
        } label: {
            Label("All tools", systemImage: "house")
        }
        Section {
            ForEach(Tool.converterCases) { tool in
                self.row(for: tool)
            }
        } header: {
            Text("Converters").font(.title3.bold())
        }
        Section {
            ForEach(Tool.coderCases) { tool in
                self.row(for: tool)
            }
        } header: {
            Text("Encoders / Decoders").font(.title3.bold())
        }
        Section {
            ForEach(Tool.formatterCases) { tool in
                self.row(for: tool)
            }
        } header: {
            Text("Formatters").font(.title3.bold())
        }
        Section {
            ForEach(Tool.generatorCases) { tool in
                self.row(for: tool)
            }
        } header: {
            Text("Generators").font(.title3.bold())
        }
        Section {
            ForEach(Tool.textCases) { tool in
                self.row(for: tool)
            }
        } header: {
            Text("Text").font(.title3.bold())
        }
        Section {
        } header: {
            Text("Graphic").font(.title3.bold())
        }
        #if TESTING_ENABLED
            UnitTestsButton()
        #endif
    }

    private var searchResults: some View {
        ForEach(
            Tool.converterCases
                + Tool.coderCases
                + Tool.formatterCases
                + Tool.generatorCases
                + Tool.textCases
        ) { tool in
            if self.isMatch(tool.strings.localizedLongTitle) {
                self.row(for: tool, isSearchResult: true)
            }
        }
    }

    private func row(
        for tool: Tool,
        isSearchResult: Bool = false
    ) -> some View {
        let strings = tool.strings
        return NavigationLink {
            self.destination(for: tool)
        } label: {
            Label {
                Text(
                    LocalizedStringKey(
                        isSearchResult
                            ? strings.longTitle
                            : strings.shortTitle
                    ),
                    bundle: .module
                )
            } icon: {
                if strings.boldIcon {
                    Image(systemName: strings.iconName)
                        .font(.body.bold())
                } else {
                    Image(systemName: strings.iconName)
                }
            }
        }
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

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(searchQuery: "")
            .environmentObject(AppState())
            .previewPresets()
    }
}
