import Combine
import SwiftJSONFormatter

final class JSONFormatterViewModel {
    @Published var indentation = JSONIndentation.twoSpaces
    @Published var input = ""
    @Published var output = ""

    init() {
        self.$input
            .combineLatest(self.$indentation)
            .dropFirst()
            .map(Self.format)
            .assign(to: &self.$output)
    }

    private static func format(
        _ input: String,
        indentation: JSONIndentation
    ) -> String {
        switch indentation {
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

extension JSONFormatterViewModel: ObservableObject {}
