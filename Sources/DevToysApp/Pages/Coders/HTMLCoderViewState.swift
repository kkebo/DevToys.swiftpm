import Combine

@MainActor
final class HTMLCoderViewState {
    @Published var encodeMode = true {
        didSet {
            if oldValue != self.encodeMode {
                self.input = self.output
            }
        }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    private func updateOutput() {
        self.output =
            self.encodeMode
            ? HTMLCoder.encode(self.input)
            : HTMLCoder.decode(self.input)
    }
}

extension HTMLCoderViewState: ObservableObject {}
