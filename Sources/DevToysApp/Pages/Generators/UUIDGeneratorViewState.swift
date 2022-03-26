import Combine

final class UUIDGeneratorViewState {
    @Published var generator = UUIDGenerator()
    @Published var numberOfUUIDs = 1
    @Published var output = ""

    var isNumberOfUUIDsValid: Bool {
        self.numberOfUUIDs > 0
    }

    func generate() {
        let new = self.generator.generate(count: UInt(self.numberOfUUIDs))
            .joined(separator: "\n")
        if self.output.isEmpty {
            self.output = new
        } else {
            self.output += "\n" + new
        }
    }
}

extension UUIDGeneratorViewState: ObservableObject {}
