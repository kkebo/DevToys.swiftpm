import SwiftUI

struct ContentView {
    @StateObject private var state = AppState()
    @SceneStorage("selectedTool") private var selection: Tool?
    @State private var searchQuery = ""
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            Sidebar(
                state: self.state,
                selection: self.$selection,
                searchQuery: self.searchQuery
            )
            switch self.selection {
            case nil:
                AllToolsView(
                    state: self.state,
                    selection: self.$selection,
                    searchQuery: self.searchQuery
                )
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
        .searchable(
            text: self.$searchQuery,
            prompt: "Type to search for tools..."
        )
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
