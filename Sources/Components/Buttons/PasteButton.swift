import SwiftUI

struct PasteButton {
    @Binding var text: String
}

extension PasteButton: View {
    var body: some View {
        Button("Paste", systemImage: "doc.on.clipboard") {
            if let text = UIPasteboard.general.string {
                self.text = text
            }
        }
        .buttonStyle(.toolbar)
        .hoverEffect()
    }
}

struct PasteButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PasteButton(text: .constant("")).environment(\.horizontalSizeClass, .regular)
            PasteButton(text: .constant("")).environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
