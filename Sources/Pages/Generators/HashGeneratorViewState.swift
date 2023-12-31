import Observation

@Observable
final class HashGeneratorViewState {
    var generator = HashGenerator() {
        didSet { self.updateOutputValues() }
    }
    var input = "" {
        didSet { self.updateOutputValues() }
    }
    private(set) var md5 = ""
    private(set) var sha1 = ""
    private(set) var sha256 = ""
    private(set) var sha512 = ""

    private func updateOutputValues() {
        let value = self.input
        self.md5 = self.generator.generateMD5(value)
        self.sha1 = self.generator.generateSHA1(value)
        self.sha256 = self.generator.generateSHA256(value)
        self.sha512 = self.generator.generateSHA512(value)
    }
}
