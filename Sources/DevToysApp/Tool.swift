import SwiftUI

let toolGroups: [ToolGroup] = [
    .init(
        name: "Converters",
        tools: [
            .jsonYAMLConverter,
            .timestampConverter,
            .numberBaseConverter,
        ]
    ),
    .init(
        name: "Encoders / Decoders",
        tools: [
            .htmlCoder,
            .urlCoder,
            .base64Coder,
            .jwtDecoder,
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
            .uuidGenerator,
            .loremIpsumGenerator,
        ]
    ),
    .init(
        name: "Text",
        tools: [.markdownPreview]
    ),
    .init(
        name: "Graphic",
        tools: []
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
    case loremIpsumGenerator
    case markdownPreview
    case numberBaseConverter
    case timestampConverter
    case urlCoder
    case uuidGenerator

    var strings: Strings {
        switch self {
        case .allTools:
            return .init(
                shortTitle: "All tools",
                longTitle: "All tools",
                description: ""
            )
        case .base64Coder:
            return .init(
                shortTitle: "Base 64",
                longTitle: "Base 64 Encoder / Decoder",
                description: "Encode and decode Base64 data"
            )
        case .hashGenerator:
            return .init(
                shortTitle: "Hash",
                longTitle: "Hash Generator",
                description: "Calculate MD5, SHA1, SHA256 and SHA512 hash from text data"
            )
        case .htmlCoder:
            return .init(
                shortTitle: "HTML",
                longTitle: "HTML Encoder / Decoder",
                description: "Encode or decode all the applicable characters to their corresponding HTML entities"
            )
        case .jsonFormatter:
            return .init(
                shortTitle: "JSON",
                longTitle: "JSON Formatter",
                description: "Indent or minify JSON data"
            )
        case .jsonYAMLConverter:
            return .init(
                shortTitle: "JSON <> YAML",
                longTitle: "JSON <> YAML Converter",
                description: "Convert JSON data to YAML and vice versa"
            )
        case .jwtDecoder:
            return .init(
                shortTitle: "JWT Decoder",
                longTitle: "JWT Decoder",
                description: "Decode a JWT header, payload and signature"
            )
        case .loremIpsumGenerator:
            return .init(
                shortTitle: "Lorem Ipsum",
                longTitle: "Lorem Ipsum Generator",
                description: "Generate Lorem Ipsum placeholder text"
            )
        case .markdownPreview:
            return .init(
                shortTitle: "Markdown Preview",
                longTitle: "Markdown Preview",
                description: "Preview a Markdown document"
            )
        case .numberBaseConverter:
            return .init(
                shortTitle: "Number Base",
                longTitle: "Number Base Converter",
                description: "Convert numbers from one base to another"
            )
        case .timestampConverter:
            return .init(
                shortTitle: "Timestamp",
                longTitle: "Unix Timestamp Converter",
                description: "Convert timestamp to human-readable date and vice versa"
            )
        case .urlCoder:
            return .init(
                shortTitle: "URL",
                longTitle: "URL Encoder / Decoder",
                description: "Encode or decode all the applicable characters to their corresponding URL entities"
            )
        case .uuidGenerator:
            return .init(
                shortTitle: "UUID",
                longTitle: "UUID Generator",
                description: "Generate UUIDs version 1 and 4"
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
        case .jsonYAMLConverter: JSONYAMLConverterView()
        case .jwtDecoder: JWTDecoderView(state: state)
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
