import Combine

final class LoremIpsumGeneratorViewState {
    @Published var generator = LoremIpsumGenerator() {
        didSet { self.updateOutput() }
    }
    @Published var length = 1 {
        didSet {
            guard self.isLengthValid else { return }
            guard self.generator.length != self.length else { return }
            self.generator.length = self.length
        }
    }
    @Published var output = ""

    var isLengthValid: Bool {
        self.length > 0
    }

    init() {
        self.updateOutput()
    }

    private func updateOutput() {
        self.output = self.generator.generate()
    }
}

extension LoremIpsumGeneratorViewState: ObservableObject {}
