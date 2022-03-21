import Combine
import SwiftJSONFormatter

final class JSONFormatterViewModel {
    @Published var indentation = JSONIndentation.twoSpaces {
        didSet { self.updateOutput() }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    init() {}

    private func updateOutput() {
        self.output = Self.format(self.input, indentation: self.indentation)
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
