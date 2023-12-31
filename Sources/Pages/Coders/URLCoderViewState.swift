import Observation

@Observable
final class URLCoderViewState {
    var encodeMode = true {
        didSet {
            if oldValue != self.encodeMode {
                self.input = self.output
            }
        }
    }
    var input = "" {
        didSet { self.updateOutput() }
    }
    private(set) var output = ""

    private func updateOutput() {
        self.output =
            self.encodeMode
            ? URLCoder.encode(self.input) ?? ""
            : URLCoder.decode(self.input) ?? ""
    }
}
