enum Tool: String {
    case base64Coder
    case hashGenerator
    case htmlCoder
    case jsonFormatter
    case jsonYAMLConverter
    case jwtDecoder
    case loremIpsumGenerator
    case markdownPreview
    case numberBaseConverter
    case urlCoder
    case uuidGenerator

    static var converterCases: [Self] {
        [
            .jsonYAMLConverter,
            .numberBaseConverter,
        ]
    }

    static var coderCases: [Self] {
        [
            .htmlCoder,
            .urlCoder,
            .base64Coder,
            .jwtDecoder,
        ]
    }

    static var formatterCases: [Self] {
        [.jsonFormatter]
    }

    static var generatorCases: [Self] {
        [
            .hashGenerator,
            .uuidGenerator,
            .loremIpsumGenerator,
        ]
    }

    static var textCases: [Tool] {
        [.markdownPreview]
    }

    var strings: Strings {
        switch self {
        case .base64Coder:
            return .init(
                shortTitle: "Base 64",
                longTitle: "Base 64 Encoder / Decoder",
                iconName: "b.square",
                description: "Encode and decode Base64 data"
            )
        case .hashGenerator:
            return .init(
                shortTitle: "Hash",
                longTitle: "Hash Generator",
                iconName: "number",
                description: "Calculate MD5, SHA1, SHA256 and SHA512 hash from text data"
            )
        case .htmlCoder:
            return .init(
                shortTitle: "HTML",
                longTitle: "HTML Encoder / Decoder",
                iconName: "chevron.left.slash.chevron.right",
                description: "Encode or decode all the applicable characters to their corresponding HTML entities"
            )
        case .jsonFormatter:
            return .init(
                shortTitle: "JSON",
                longTitle: "JSON Formatter",
                iconName: "curlybraces",
                description: "Indent or minify JSON data"
            )
        case .jsonYAMLConverter:
            return .init(
                shortTitle: "JSON <> YAML",
                longTitle: "JSON <> YAML Converter",
                iconName: "doc.plaintext",
                description: "Convert JSON data to YAML and vice versa"
            )
        case .jwtDecoder:
            return .init(
                shortTitle: "JWT Decoder",
                longTitle: "JWT Decoder",
                iconName: "rays",
                boldIcon: true,
                description: "Decode a JWT header, payload and signature"
            )
        case .loremIpsumGenerator:
            return .init(
                shortTitle: "Lorem Ipsum",
                longTitle: "Lorem Ipsum Generator",
                iconName: "text.alignleft",
                description: "Generate Lorem Ipsum placeholder text"
            )
        case .markdownPreview:
            return .init(
                shortTitle: "Markdown Preview",
                longTitle: "Markdown Preview",
                iconName: "arrow.down.square",
                description: "Preview a Markdown document"
            )
        case .numberBaseConverter:
            return .init(
                shortTitle: "Number Base",
                longTitle: "Number Base Converter",
                iconName: "number.square",
                description: "Convert numbers from one base to another"
            )
        case .urlCoder:
            return .init(
                shortTitle: "URL",
                longTitle: "URL Encoder / Decoder",
                iconName: "link",
                description: "Encode or decode all the applicable characters to their corresponding URL entities"
            )
        case .uuidGenerator:
            return .init(
                shortTitle: "UUID",
                longTitle: "UUID Generator",
                iconName: "01.square",
                description: "Generate UUIDs version 1 and 4"
            )
        }
    }
}

extension Tool: Identifiable {
    var id: Self { self }
}

extension Tool: CaseIterable {}

extension Tool: Codable {}
