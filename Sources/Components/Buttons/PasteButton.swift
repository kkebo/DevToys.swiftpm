import SwiftUI

struct PasteButton {
    @Binding var text: String
    @Environment(\.horizontalSizeClass) private var hSizeClass
}

extension PasteButton: View {
    var body: some View {
        Button {
            self.text = UIPasteboard.general.string ?? ""
        } label: {
            if self.hSizeClass == .compact {
                Label("Paste", systemImage: "doc.on.clipboard")
                    .labelStyle(.iconOnly)
            } else {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
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
