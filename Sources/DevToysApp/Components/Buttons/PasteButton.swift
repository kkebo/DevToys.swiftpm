import SwiftUI

struct PasteButton {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Binding var text: String
    let additionalAction: () -> Void

    init(
        text: Binding<String>,
        additionalAction: @escaping () -> Void = {}
    ) {
        self._text = text
        self.additionalAction = additionalAction
    }
}

extension PasteButton: View {
    var body: some View {
        Button {
            self.text = UIPasteboard.general.string ?? ""
            self.additionalAction()
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
