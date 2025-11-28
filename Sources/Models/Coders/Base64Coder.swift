import struct Foundation.Data

enum Base64CoderEncoding {
    case utf8
    case ascii

    func encode(_ str: String) -> Data {
        switch self {
        case .utf8: Data(str.utf8)
        case .ascii: Data(self.decode(Data(str.utf8)).utf8)
        }
    }

    func decode(_ data: Data) -> String {
        switch self {
        case .utf8: String(decoding: data, as: UTF8.self)
        case .ascii: String(decoding: data, as: Unicode.ASCII.self)
        }
    }
}

struct Base64Coder {
    var encoding = Base64CoderEncoding.utf8

    func encode(_ input: String) -> String {
        self.encoding.encode(input).base64EncodedString()
    }

    func decode(_ input: String) -> String? {
        Data(base64Encoded: input).map(self.encoding.decode)
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
                "77+977+977+977+9",
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
                "������������",
                other: coder.decode("77+977+977+977+9")
            )
        }
    }
#endif
