import Combine
import struct Foundation.Data

final class Base64EncoderDecoderViewModel {
    @Published var encodeMode = true {
        didSet {
            if oldValue != self.encodeMode {
                self.input = self.output
            }
        }
    }
    @Published var encoding = String.Encoding.utf8 {
        didSet { self.updateOutput() }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    init() {}

    private func updateOutput() {
        self.output = self.encodeMode
            ? Self.encode(self.input, encoding: self.encoding) ?? ""
            : Self.decode(self.input, encoding: self.encoding) ?? ""
    }

    private static func encode(
        _ input: String,
        encoding: String.Encoding
    ) -> String? {
        input.data(using: encoding)?
            .base64EncodedString()
    }

    private static func decode(
        _ input: String,
        encoding: String.Encoding
    ) -> String? {
        Data(base64Encoded: input)
            .flatMap { .init(data: $0, encoding: encoding) }
    }
}

extension Base64EncoderDecoderViewModel: ObservableObject {}
