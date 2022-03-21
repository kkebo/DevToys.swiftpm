import Combine
import HTMLEntities

final class HTMLEncoderDecoderViewModel {
    @Published var encodeMode = true {
        didSet {
            if oldValue != self.encodeMode {
                self.input = self.output
            }
        }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    private func updateOutput() {
        self.output = self.encodeMode
            ? Self.encode(self.input)
            : Self.decode(self.input)
    }

    private static func encode(_ input: String) -> String {
        input.htmlEscape(useNamedReferences: true)
    }

    private static func decode(_ input: String) -> String {
        input.htmlUnescape()
    }
}

extension HTMLEncoderDecoderViewModel: ObservableObject {}
