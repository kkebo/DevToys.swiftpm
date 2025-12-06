import SwiftUI

struct CopyButton {
    let text: String
}

extension CopyButton: View {
    var body: some View {
        Button("Copy", systemImage: "doc.on.doc") {
            UIPasteboard.general.string = self.text
        }
        .buttonStyle(.toolbar)
        .hoverEffect()
        .disabled(self.text.isEmpty)
    }
}

struct CopyButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CopyButton(text: "foobar").environment(\.horizontalSizeClass, .regular)
            CopyButton(text: "foobar").environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
