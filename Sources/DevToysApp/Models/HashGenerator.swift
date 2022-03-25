import CryptoKit

struct HashGenerator {
    var isUppercase = false

    func generate<F: HashFunction>(
        _ input: String,
        type: F.Type
    ) -> [UInt8] {
        guard !input.isEmpty else { return [] }
        guard let data = input.data(using: .utf8) else { return [] }
        return Array(F.hash(data: data))
    }

    func generate<F: HashFunction>(
        _ input: String,
        type: F.Type
    ) -> String {
        let out: String = self.generate(input, type: type).lazy
            .map { String($0, radix: 16) }
            .joined()
        return self.isUppercase ? out.uppercased() : out
    }

    func generateMD5(_ input: String) -> String {
        self.generate(input, type: Insecure.MD5.self)
    }

    func generateSHA1(_ input: String) -> String {
        self.generate(input, type: Insecure.SHA1.self)
    }

    func generateSHA256(_ input: String) -> String {
        self.generate(input, type: SHA256.self)
    }

    func generateSHA512(_ input: String) -> String {
        self.generate(input, type: SHA512.self)
    }
}

#if TESTING_ENABLED
import PlaygroundTester

@objcMembers
final class HashGeneratorTests: TestCase {
    func testGenerateMD5() {
        let generator = HashGenerator()
        AssertEqual(
            "b9a4f035019096a2f939352b369258bc",
            other: generator.generateMD5("Hello there !")
        )
    }

    func testGenerateMD5Uppercase() {
        var generator = HashGenerator()
        generator.isUppercase = true
        AssertEqual(
            "B9A4F035019096A2F939352B369258BC",
            other: generator.generateMD5("Hello there !")
        )
    }

    func testGenerateSHA1() {
        let generator = HashGenerator()
        AssertEqual(
            "8fa581f55caecb0bc1da080202f64836b146aa40",
            other: generator.generateSHA1("Hello there !")
        )
    }

    func testGenerateSHA256() {
        let generator = HashGenerator()
        AssertEqual(
            "472f86ad5b7bcd90eff6147fd6f8fb755ac3b1ab8bf712e6a19467f5d6bfafd3",
            other: generator.generateSHA256("Hello there !")
        )
    }

    func testGenerateSHA512() {
        let generator = HashGenerator()
        AssertEqual(
            "1b5e4b2ea5e1e23c5649ece43bf3e674b7a90b3fc71a54badf3b7841ebe7e223da976f092f44adf04a2494199abfb6aa1d23ec11d0296210d6f76cd76d943ec7",
            other: generator.generateSHA512("Hello there !")
        )
    }
}
#endif
