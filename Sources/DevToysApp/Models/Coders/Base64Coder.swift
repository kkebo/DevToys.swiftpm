import struct Foundation.Data

struct Base64Coder {
    var encoding = String.Encoding.utf8

    func encode(_ input: String) -> String? {
        input.data(using: self.encoding, allowLossyConversion: true)?
            .base64EncodedString()
    }

    func decode(_ input: String) -> String? {
        Data(base64Encoded: input)
            .flatMap { .init(data: $0, encoding: self.encoding) }
    }
}

#if TESTING_ENABLED
import PlaygroundTester

@objcMembers
final class Base64CoderTests: TestCase {
    func testEncodeUTF8() {
        let coder = Base64Coder()
        AssertEqual(
            "SGVsbG8gdGhlcmUgIQ==",
            other: coder.encode("Hello there !")
        )
        AssertEqual(
            "8J+rgw==",
            other: coder.encode("🫃")
        )
    }

    func testDecodeUTF8() {
        let coder = Base64Coder()
        AssertEqual(
            "Hello there !",
            other: coder.decode("SGVsbG8gdGhlcmUgIQ==")
        )
        AssertEqual(
            "🫃",
            other: coder.decode("8J+rgw==")
        )
    }

    func testEncodeASCII() {
        var coder = Base64Coder()
        coder.encoding = .ascii
        AssertEqual(
            "SGVsbG8gdGhlcmUgIQ==",
            other: coder.encode("Hello there !")
        )
        AssertEqual(
            "Pw==",
            other: coder.encode("🫃")
        )
    }

    func testDecodeASCII() {
        var coder = Base64Coder()
        coder.encoding = .ascii
        AssertEqual(
            "Hello there !",
            other: coder.decode("SGVsbG8gdGhlcmUgIQ==")
        )
        AssertEqual(
            "?",
            other: coder.decode("Pw==")
        )
    }
}
#endif
