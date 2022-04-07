import Combine

final class MarkdownPreviewViewState {
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""
    private let compiler = MarkdownCompiler()

    private func updateOutput() {
        self.output = self.compiler.compileToHTML(self.input)
    }
}

extension MarkdownPreviewViewState: ObservableObject {}
