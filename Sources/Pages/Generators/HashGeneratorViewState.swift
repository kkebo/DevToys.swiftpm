import Observation

@Observable
final class HashGeneratorViewState {
    var generator = HashGenerator() {
        didSet { self.updateOutputValues() }
    }
    var input = "" {
        didSet { self.updateOutputValues() }
    }
    private(set) var output = ""

    private func updateOutputValues() {
        self.output = self.generator.generate(self.input)
    }
}
