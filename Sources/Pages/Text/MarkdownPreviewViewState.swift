import Observation

@Observable
final class MarkdownPreviewViewState {
    var input = "" {
        didSet { self.updateOutput() }
    }
    private(set) var output = ""
    private let compiler = MarkdownCompiler()

    private func updateOutput() {
        self.output = self.compiler.compileToHTML(self.input)
    }
}
