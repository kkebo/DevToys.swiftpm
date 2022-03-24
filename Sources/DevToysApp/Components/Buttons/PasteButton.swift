import SwiftUI

struct PasteButton {
    @Binding var text: String
}

extension PasteButton: View {
    var body: some View {
        Button {
            self.text = UIPasteboard.general.string ?? ""
        } label: {
            Label("Paste", systemImage: "doc.on.clipboard")
        }
        .buttonStyle(.bordered)
        .hoverEffect()
    }
}

struct PasteButton_Previews: PreviewProvider {
    static var previews: some View {
        PasteButton(text: .constant(""))
            .previewPresets()
    }
}
