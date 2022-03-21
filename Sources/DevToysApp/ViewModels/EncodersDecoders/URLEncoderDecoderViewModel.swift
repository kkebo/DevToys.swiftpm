import Combine

final class URLEncoderDecoderViewModel {
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

    init() {}

    private func updateOutput() {
        self.output = self.encodeMode
            ? Self.encode(self.input) ?? ""
            : Self.decode(self.input) ?? ""
    }

    private static func encode(_ input: String) -> String? {
        input.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(
                    .init(charactersIn: ":#[]@!$&'()*+,;=")
                )
        )
    }

    private static func decode(_ input: String) -> String? {
        input.removingPercentEncoding
    }
}

extension URLEncoderDecoderViewModel: ObservableObject {}
