import Combine

final class HashGeneratorViewState {
    @Published var generator = HashGenerator() {
        didSet { self.updateOutputValues() }
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
        self.md5 = self.generator.generateMD5(value)
        self.sha1 = self.generator.generateSHA1(value)
        self.sha256 = self.generator.generateSHA256(value)
        self.sha512 = self.generator.generateSHA512(value)
    }
}

extension HashGeneratorViewState: ObservableObject {}
