import Combine
import CryptoKit

final class HashGeneratorViewModel {
    @Published var isUppercase = false
    @Published var input = ""
    @Published var md5 = ""
    @Published var sha1 = ""
    @Published var sha256 = ""
    @Published var sha512 = ""

    init() {
        let inputWithOptions = self.$input
            .combineLatest(self.$isUppercase)
            .dropFirst()

        inputWithOptions
            .map {
                Self.generate($0, type: Insecure.MD5.self, uppercase: $1)
            }
            .assign(to: &self.$md5)
        inputWithOptions
            .map {
                Self.generate($0, type: Insecure.SHA1.self, uppercase: $1)
            }
            .assign(to: &self.$sha1)
        inputWithOptions
            .map { Self.generate($0, type: SHA256.self, uppercase: $1) }
            .assign(to: &self.$sha256)
        inputWithOptions
            .map { Self.generate($0, type: SHA512.self, uppercase: $1) }
            .assign(to: &self.$sha512)
    }

    private static func generate<F: HashFunction>(
        _ input: String,
        type: F.Type,
        uppercase: Bool
    ) -> String {
        guard !input.isEmpty else { return "" }
        guard let data = input.data(using: .utf8) else { return "" }
        let output: String = F.hash(data: data).lazy
            .map { String($0, radix: 16) }
            .joined()
        return uppercase ? output.uppercased() : output
    }
}

extension HashGeneratorViewModel: ObservableObject {}
