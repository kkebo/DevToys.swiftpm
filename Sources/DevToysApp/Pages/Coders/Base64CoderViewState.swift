import Combine

@MainActor
final class Base64CoderViewState {
    @Published var coder = Base64Coder() {
        didSet { self.updateOutput() }
    }
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
            ? self.coder.encode(self.input) ?? ""
            : self.coder.decode(self.input) ?? ""
    }
}

extension Base64CoderViewState: ObservableObject {}
