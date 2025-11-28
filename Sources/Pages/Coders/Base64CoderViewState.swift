import Observation

@Observable
final class Base64CoderViewState {
    var coder = Base64Coder() {
        didSet { self.updateOutput() }
    }
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
            ? self.coder.encode(self.input)
            : self.coder.decode(self.input) ?? ""
    }
}
