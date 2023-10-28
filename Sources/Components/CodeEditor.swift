import CodeEditorView
import SwiftUI

struct CodeEditor {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var text: String
    @State private var position = CodeEditorView.CodeEditor.Position()
}

extension CodeEditor: View {
    var body: some View {
        CodeEditorView.CodeEditor(
            text: self.$text,
            position: self.$position,
            messages: .constant([])
        )
        .cornerRadius(8)
        .environment(\.codeEditorTheme, self.colorScheme == .dark ? .defaultDark : .defaultLight)
    }
}

struct CodeEditor_Previews: PreviewProvider {
    static var previews: some View {
        CodeEditor(text: .constant(#"print("Hello, world")"#))
            .previewPresets()
    }
}
