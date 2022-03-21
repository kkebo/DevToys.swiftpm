import Combine
import CryptoKit

final class HashGeneratorViewModel {
    @Published var isUppercase = false {
        didSet { self.formatOutputValues() }
    }
    @Published var input = "" {
        didSet { self.updateOutputValues() }
    }
    @Published var md5 = ""
    @Published var sha1 = ""
    @Published var sha256 = ""
    @Published var sha512 = ""

    private func updateOutputValues() {
        let value = self.input
        self.md5 = Self.generate(value, type: Insecure.MD5.self)
        self.sha1 = Self.generate(value, type: Insecure.SHA1.self)
        self.sha256 = Self.generate(value, type: SHA256.self)
        self.sha512 = Self.generate(value, type: SHA512.self)
        self.formatOutputValues(ignoreLowercase: true)
    }

    private func formatOutputValues(ignoreLowercase: Bool = false) {
        if self.isUppercase {
            self.md5 = self.md5.uppercased()
            self.sha1 = self.sha1.uppercased()
            self.sha256 = self.sha256.uppercased()
            self.sha512 = self.sha512.uppercased()
        } else if !ignoreLowercase {
            self.md5 = self.md5.lowercased()
            self.sha1 = self.sha1.lowercased()
            self.sha256 = self.sha256.lowercased()
            self.sha512 = self.sha512.lowercased()
        }
    }

    private static func generate<F: HashFunction>(
        _ input: String,
        type: F.Type
    ) -> String {
        guard !input.isEmpty else { return "" }
        guard let data = input.data(using: .utf8) else { return "" }
        return F.hash(data: data).lazy
            .map { String($0, radix: 16) }
            .joined()
    }
}

extension HashGeneratorViewModel: ObservableObject {}
