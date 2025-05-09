import SwiftUI

let toolGroups: [ToolGroup] = [
    .init(
        name: "Converters",
        tools: [
            .jsonYAMLConverter,
            .numberBaseConverter,
            .timestampConverter,
        ]
    ),
    .init(
        name: "Encoders / Decoders",
        tools: [
            .base64Coder,
            .htmlCoder,
            .jwtDecoder,
            .urlCoder,
        ]
    ),
    .init(
        name: "Formatters",
        tools: [.jsonFormatter]
    ),
    .init(
        name: "Generators",
        tools: [
            .hashGenerator,
            .loremIpsumGenerator,
            .uuidGenerator,
        ]
    ),
    .init(
        name: "Graphic",
        tools: []
    ),
    .init(
        name: "Testers",
        tools: []
    ),
    .init(
        name: "Text",
        tools: [
            .listComparer,
            .markdownPreview,
        ]
    ),
]

enum Tool: String {
    case allTools
    case base64Coder
    case hashGenerator
    case htmlCoder
    case jsonFormatter
    case jsonYAMLConverter
    case jwtDecoder
    case listComparer
    case loremIpsumGenerator
    case markdownPreview
    case numberBaseConverter
    case timestampConverter
    case urlCoder
    case uuidGenerator

    var strings: Strings {
        switch self {
        case .allTools:
            .init(
                shortTitle: "All tools",
                longTitle: "All tools",
                description: ""
            )
        case .base64Coder:
            .init(
                shortTitle: "Base64 Text",
                longTitle: "Base64 Text Encoder / Decoder",
                description: "Encode and decode Base64 text data"
            )
        case .hashGenerator:
            .init(
                shortTitle: "Hash",
                longTitle: "Hash Generator",
                description: "Calculate hash from text data"
            )
        case .htmlCoder:
            .init(
                shortTitle: "HTML",
                longTitle: "HTML Text Encoder / Decoder",
                description: "Encode and decode HTML text data"
            )
        case .jsonFormatter:
            .init(
                shortTitle: "JSON",
                longTitle: "JSON Formatter",
                description: "Indent or minify JSON data"
            )
        case .jsonYAMLConverter:
            .init(
                shortTitle: "JSON <> YAML",
                longTitle: "JSON <> YAML Converter",
                description: "Convert JSON data to YAML and vice versa"
            )
        case .jwtDecoder:
            .init(
                shortTitle: "JWT Decoder",
                longTitle: "JWT Decoder",
                description: "Decode JSON Web Token"
            )
        case .listComparer:
            .init(
                shortTitle: "List Compare",
                longTitle: "List Comparer",
                description: "Compare two lists"
            )
        case .loremIpsumGenerator:
            .init(
                shortTitle: "Lorem Ipsum",
                longTitle: "Lorem Ipsum Generator",
                description: "Generate Lorem Ipsum placeholder text"
            )
        case .markdownPreview:
            .init(
                shortTitle: "Markdown Preview",
                longTitle: "Markdown Preview",
                description: "Preview a Markdown document"
            )
        case .numberBaseConverter:
            .init(
                shortTitle: "Number Base",
                longTitle: "Number Base Converter",
                description: "Convert numbers from one base to another"
            )
        case .timestampConverter:
            .init(
                shortTitle: "Timestamp",
                longTitle: "Unix Timestamp Converter",
                description: "Convert timestamp to human-readable date and vice versa"
            )
        case .urlCoder:
            .init(
                shortTitle: "URL",
                longTitle: "URL Encoder / Decoder",
                description: "Encode or decode all the applicable characters to their corresponding URL entities"
            )
        case .uuidGenerator:
            .init(
                shortTitle: "UUID",
                longTitle: "UUID Generator",
                description: "Generate UUIDs version 1 and 4 (GUID)"
            )
        }
    }

    @ViewBuilder var icon: some View {
        switch self {
        case .allTools:
            Image(systemName: "house")
        case .base64Coder:
            Image(systemName: "b").symbolVariant(.square)
        case .hashGenerator:
            Image(systemName: "number")
        case .htmlCoder:
            Image(systemName: "chevron.left.slash.chevron.right")
        case .jsonFormatter:
            Image(systemName: "curlybraces")
        case .jsonYAMLConverter:
            Image(systemName: "doc.plaintext")
        case .jwtDecoder:
            Image("JWT").resizable().scaledToFit()
        case .listComparer:
            Image(systemName: "list.bullet.rectangle.portrait")
        case .loremIpsumGenerator:
            Image(systemName: "text.alignleft")
        case .markdownPreview:
            Image(systemName: "arrow.down").symbolVariant(.square)
        case .numberBaseConverter:
            Image(systemName: "number").symbolVariant(.square)
        case .timestampConverter:
            Image(systemName: "clock")
        case .urlCoder:
            Image(systemName: "link")
        case .uuidGenerator:
            Image(systemName: "01").symbolVariant(.square)
        }
    }

    @MainActor
    @ViewBuilder
    func page(state: AppState, selection: Binding<Tool?>, searchQuery: Binding<String>) -> some View {
        switch self {
        case .allTools: AllToolsView(state: state, selection: selection, searchQuery: searchQuery)
        case .base64Coder: Base64CoderView(state: state)
        case .hashGenerator: HashGeneratorView(state: state)
        case .htmlCoder: HTMLCoderView(state: state)
        case .jsonFormatter: JSONFormatterView(state: state)
        case .jsonYAMLConverter: JSONYAMLConverterView(state: state)
        case .jwtDecoder: JWTDecoderView(state: state)
        case .listComparer: ListComparerView(state: state)
        case .loremIpsumGenerator: LoremIpsumGeneratorView(state: state)
        case .markdownPreview: MarkdownPreviewView(state: state)
        case .numberBaseConverter: NumberBaseConverterView(state: state)
        case .timestampConverter: TimestampConverterView(state: state)
        case .urlCoder: URLCoderView(state: state)
        case .uuidGenerator: UUIDGeneratorView(state: state)
        }
    }
}

extension Tool: Identifiable {
    var id: Self { self }
}

extension Tool: CaseIterable {
    static var allCases: [Tool] {
        [
            .base64Coder,
            .hashGenerator,
            .htmlCoder,
            .jsonFormatter,
            .jsonYAMLConverter,
            .jwtDecoder,
            .listComparer,
            .loremIpsumGenerator,
            .markdownPreview,
            .numberBaseConverter,
            .timestampConverter,
            .urlCoder,
            .uuidGenerator,
        ]
    }
}

extension Tool: Codable {}
