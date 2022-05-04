import Combine

final class LoremIpsumGeneratorViewState {
    static let defaultLength = 1

    @Published var generator = LoremIpsumGenerator() {
        didSet { self.updateOutput() }
    }
    @Published var lengthString = 
        String(LoremIpsumGeneratorViewState.defaultLength)
    @Published var length = LoremIpsumGeneratorViewState.defaultLength {
        didSet {
            self.updateLengthString()
            guard self.generator.length != self.length else { return }
            self.generator.length = self.length
        }
    }
    @Published var output = ""

    init() {
        self.updateOutput()
    }

    func commitLength() {
        guard !self.lengthString.isEmpty else {
            self.lengthString = 
                String(LoremIpsumGeneratorViewState.defaultLength)
            self.length = LoremIpsumGeneratorViewState.defaultLength
            return
        }
        guard let value = Int(self.lengthString) else {
            self.lengthString = String(self.length)
            return
        }
        if self.length != value { 
            self.length = max(1, min(.init(Int32.max), value))
        }
    }

    private func updateLengthString() {
        let string = String(self.length)
        if self.lengthString != string {
            self.lengthString = string
        }
    }

    private func updateOutput() {
        self.output = self.generator.generate()
    }
}

extension LoremIpsumGeneratorViewState: ObservableObject {}
