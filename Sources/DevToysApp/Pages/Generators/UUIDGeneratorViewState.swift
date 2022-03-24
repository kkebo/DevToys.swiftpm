import Combine

final class UUIDGeneratorViewState {
    @Published var generator = UUIDGenerator()
    @Published var numberOfUUIDsString: String = "1"
    @Published var numberOfUUIDs: UInt?
    @Published var output = ""

    init() {
        self.$numberOfUUIDsString
            .map(UInt.init)
            .assign(to: &self.$numberOfUUIDs)
    }

    func generate() {
        guard let n = self.numberOfUUIDs else { return }

        let new = self.generator.generate(count: n).joined(separator: "\n")
        if self.output.isEmpty {
            self.output = new
        } else {
            self.output += "\n" + new
        }
    }
}

extension UUIDGeneratorViewState: ObservableObject {}
