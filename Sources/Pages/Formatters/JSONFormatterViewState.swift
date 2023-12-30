import Observation

@Observable
final class JSONFormatterViewState {
    var formatter = JSONFormatter() {
        didSet { self.updateOutput() }
    }
    var input = "" {
        didSet { self.updateOutput() }
    }
    private(set) var output = ""

    private func updateOutput() {
        self.output = self.formatter.format(self.input)
    }
}
