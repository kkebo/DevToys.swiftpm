import Observation

@Observable
final class HTMLCoderViewState {
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
            ? HTMLCoder.encode(self.input)
            : HTMLCoder.decode(self.input)
    }
}
