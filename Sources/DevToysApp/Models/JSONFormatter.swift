import SwiftJSONFormatter

struct JSONFormatter {
    var indentation = JSONIndentation.twoSpaces

    func format(_ input: String) -> String {
        switch self.indentation {
        case .twoSpaces:
            return SwiftJSONFormatter.beautify(input, indent: "  ")
        case .fourSpaces:
            return SwiftJSONFormatter.beautify(input, indent: "    ")
        case .oneTab:
            return SwiftJSONFormatter.beautify(input, indent: "\t")
        case .minified:
            return SwiftJSONFormatter.minify(input)
        }
    }
}
