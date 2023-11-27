import SwiftUI

struct PasteButton {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Binding var text: String
    let preAction: () -> Void
    let postAction: () -> Void

    init(
        text: Binding<String>,
        preAction: @escaping () -> Void = {},
        postAction: @escaping () -> Void = {}
    ) {
        self._text = text
        self.preAction = preAction
        self.postAction = postAction
    }
}

extension PasteButton: View {
    var body: some View {
        Button {
            self.preAction()
            self.text = UIPasteboard.general.string ?? ""
            self.postAction()
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
