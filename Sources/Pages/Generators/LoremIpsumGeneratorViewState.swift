import Observation

@Observable
final class LoremIpsumGeneratorViewState {
    static let defaultLength = 1

    var generator = LoremIpsumGenerator() {
        didSet { self.generate() }
    }
    var lengthString = String(LoremIpsumGeneratorViewState.defaultLength)
    var length = LoremIpsumGeneratorViewState.defaultLength {
        didSet {
            self.updateLengthString()
            guard self.generator.length != self.length else { return }
            self.generator.length = self.length
        }
    }
    var output = ""

    init() {
        self.generate()
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

    func generate() {
        self.output = self.generator.generate()
    }
}
