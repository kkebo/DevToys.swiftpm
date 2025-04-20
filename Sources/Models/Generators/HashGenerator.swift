import CryptoKit

import struct Foundation.Data

struct HashGenerator {
    var algorithm = HashAlgorithm.md5
    var isUppercase = false
    var outputType = HashOutputType.hex

    func generate(_ input: String) -> String {
        guard !input.isEmpty else { return "" }
        let inputData = Data(input.utf8)
        let outputData =
            switch self.algorithm {
            case .md5: Data(Insecure.MD5.hash(data: inputData))
            case .sha1: Data(Insecure.SHA1.hash(data: inputData))
            case .sha256: Data(SHA256.hash(data: inputData))
            case .sha384: Data(SHA384.hash(data: inputData))
            case .sha512: Data(SHA512.hash(data: inputData))
            }
        switch self.outputType {
        case .hex:
            let format = self.isUppercase ? "%02X" : "%02x"
            return outputData.lazy
                .map { String(format: format, $0) }
                .joined()
        case .base64:
            return outputData.base64EncodedString()
        }
    }
}

#if TESTING_ENABLED
    import PlaygroundTester

    @objcMembers
    final class HashGeneratorTests: TestCase {
        func testGenerateMD5() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            AssertEqual(
                "b9a4f035019096a2f939352b369258bc",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateMD5Uppercase() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.isUppercase = true
            AssertEqual(
                "B9A4F035019096A2F939352B369258BC",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateMD5Base64() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.outputType = .base64
            AssertEqual(
                "uaTwNQGQlqL5OTUrNpJYvA==",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA1() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            AssertEqual(
                "8fa581f55caecb0bc1da080202f64836b146aa40",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA1Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            generator.outputType = .base64
            AssertEqual(
                "j6WB9VyuywvB2ggCAvZINrFGqkA=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA256() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            AssertEqual(
                "472f86ad5b7bcd90eff6147fd6f8fb755ac3b1ab8bf712e6a19467f5d6bfafd3",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA256Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            generator.outputType = .base64
            AssertEqual(
                "Ry+GrVt7zZDv9hR/1vj7dVrDsauL9xLmoZRn9da/r9M=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA384() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            AssertEqual(
                "d8d70b6d20a02a4ec4de87f9047faef0dc467f049480043e954514be843d68950e6f8a20a6debe3bcd3bb4889a646590",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA384Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            generator.outputType = .base64
            AssertEqual(
                "2NcLbSCgKk7E3of5BH+u8NxGfwSUgAQ+lUUUvoQ9aJUOb4ogpt6+O807tIiaZGWQ",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA512() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            AssertEqual(
                "1b5e4b2ea5e1e23c5649ece43bf3e674b7a90b3fc71a54badf3b7841ebe7e223da976f092f44adf04a2494199abfb6aa1d23ec11d0296210d6f76cd76d943ec7",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA512Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            generator.outputType = .base64
            AssertEqual(
                "G15LLqXh4jxWSezkO/PmdLepCz/HGlS63zt4Qevn4iPal28JL0St8EoklBmav7aqHSPsEdApYhDW92zXbZQ+xw==",
                other: generator.generate("Hello there !")
            )
        }
    }
#endif
