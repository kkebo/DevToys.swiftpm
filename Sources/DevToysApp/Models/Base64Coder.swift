import struct Foundation.Data

struct Base64Coder {
    var encoding = String.Encoding.utf8

    func encode(_ input: String) -> String? {
        input.data(using: self.encoding)?
            .base64EncodedString()
    }

    func decode(_ input: String) -> String? {
        Data(base64Encoded: input)
            .flatMap { .init(data: $0, encoding: self.encoding) }
    }
}
