import Combine

@MainActor
final class JSONFormatterViewState {
    @Published var formatter = JSONFormatter() {
        didSet { self.updateOutput() }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    private func updateOutput() {
        self.output = self.formatter.format(self.input)
    }
}

extension JSONFormatterViewState: ObservableObject {}
