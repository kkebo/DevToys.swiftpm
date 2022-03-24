import Combine

final class URLCoderViewState {
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
        self.output = self.encodeMode
            ? URLCoder.encode(self.input) ?? ""
            : URLCoder.decode(self.input) ?? ""
    }
}

extension URLCoderViewState: ObservableObject {}
