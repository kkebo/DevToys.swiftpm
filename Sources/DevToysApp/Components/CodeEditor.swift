import SwiftUI

struct CodeEditor {
    @Binding var text: String
}

extension CodeEditor: View {
    var body: some View {
        TextEditor(text: self.$text)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.body.monospaced())
            .scrollContentBackground(.hidden)
            .background(.regularMaterial)
            .cornerRadius(8)
    }
}

struct CodeEditor_Previews: PreviewProvider {
    static var previews: some View {
        CodeEditor(text: .constant(#"print("Hello, world")"#))
            .previewPresets()
    }
}
