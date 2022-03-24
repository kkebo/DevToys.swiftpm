import SwiftUI

struct CopyButton {
    let text: String
}

extension CopyButton: View {
    var body: some View {
        Button {
            UIPasteboard.general.string = self.text
        } label: {
            Label("Copy", systemImage: "doc.on.doc")
        }
        .buttonStyle(.bordered)
        .hoverEffect()
    }
}

struct CopyButton_Previews: PreviewProvider {
    static var previews: some View {
        CopyButton(text: "foobar")
            .previewPresets()
    }
}
