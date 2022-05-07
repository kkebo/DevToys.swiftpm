import SwiftUI

struct Sidebar {
    @Environment(\.isSearching) private var isSearchMode
    @EnvironmentObject private var state: AppState
    @Binding var selection: Tool?
    let searchQuery: String

    private var isSearching: Bool {
        self.isSearchMode && !self.searchQuery.isEmpty
    }

    private var allTools: [Tool] {
        Tool.converterCases
            + Tool.coderCases
            + Tool.formatterCases
            + Tool.generatorCases
            + Tool.textCases
    }

    private var filteredTools: [Tool] {
        self.allTools.filter {
            $0.strings.localizedLongTitle
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
                ForEach(self.filteredTools, content: self.row)
            }
        }
        .navigationTitle("DevToys")
    }

    @ViewBuilder private var normalRows: some View {
        NavigationLink {
            AllToolsView(
                selection: self.$selection,
                searchQuery: self.searchQuery
            )
        } label: {
            Label("All tools", systemImage: "house")
        }
        Section {
            ForEach(Tool.converterCases, content: self.row)
        } header: {
            Text("Converters").font(.title3.bold())
        }
        Section {
            ForEach(Tool.coderCases, content: self.row)
        } header: {
            Text("Encoders / Decoders").font(.title3.bold())
        }
        Section {
            ForEach(Tool.formatterCases, content: self.row)
        } header: {
            Text("Formatters").font(.title3.bold())
        }
        Section {
            ForEach(Tool.generatorCases, content: self.row)
        } header: {
            Text("Generators").font(.title3.bold())
        }
        Section {
            ForEach(Tool.textCases, content: self.row)
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

    private func row(for tool: Tool) -> some View {
        let strings = tool.strings
        return NavigationLink(tag: tool, selection: self.$selection) {
            self.destination(for: tool)
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
        Sidebar(selection: .constant(nil), searchQuery: "")
            .environmentObject(AppState())
            .previewPresets()
    }
}
