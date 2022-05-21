import Ink

struct MarkdownCompiler {
    private let parser = MarkdownParser()

    func compileToHTML(_ input: String) -> String {
        self.parser.html(from: input)
    }
}
