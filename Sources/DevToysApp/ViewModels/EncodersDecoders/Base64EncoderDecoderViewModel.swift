import Combine
import struct Foundation.Data

final class Base64EncoderDecoderViewModel {
    @Published var encodeMode = true
    @Published var encoding = String.Encoding.utf8
    @Published var input = ""
    @Published var output = ""

    init() {
        self.$input
            .combineLatest(self.$encodeMode, self.$encoding)
            .dropFirst()
            .map { input, encodeMode, encoding in
                encodeMode
                    ? Self.encode(input, encoding: encoding)
                    : Self.decode(input, encoding: encoding)
            }
            .replaceNil(with: "")
            .assign(to: &self.$output)
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
