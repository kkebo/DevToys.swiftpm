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
