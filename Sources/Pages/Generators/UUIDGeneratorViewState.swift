import Observation

@Observable
final class UUIDGeneratorViewState {
    static let defaultNumberOfUUIDs: UInt = 1

    var generator = UUIDGenerator()
    var numberOfUUIDsString = String(UUIDGeneratorViewState.defaultNumberOfUUIDs)
    var numberOfUUIDs = UUIDGeneratorViewState.defaultNumberOfUUIDs {
        didSet { self.updateNumberOfUUIDsString() }
    }
    var output = ""

    func commitNumberOfUUIDs() {
        guard !self.numberOfUUIDsString.isEmpty else {
            self.numberOfUUIDsString =
                String(UUIDGeneratorViewState.defaultNumberOfUUIDs)
            self.numberOfUUIDs =
                UUIDGeneratorViewState.defaultNumberOfUUIDs
            return
        }
        guard let value = UInt(self.numberOfUUIDsString) else {
            self.numberOfUUIDsString = String(self.numberOfUUIDs)
            return
        }
        if self.numberOfUUIDs != value {
            self.numberOfUUIDs = max(1, min(10000, value))
        }
    }

    private func updateNumberOfUUIDsString() {
        let string = String(self.numberOfUUIDs)
        if self.numberOfUUIDsString != string {
            self.numberOfUUIDsString = string
        }
    }

    func generate() {
        let new = self.generator.generate(count: self.numberOfUUIDs)
            .joined(separator: "\n")
        if self.output.isEmpty {
            self.output = new
        } else {
            self.output += "\n" + new
        }
    }
}
