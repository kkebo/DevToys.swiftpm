import SwiftUI

struct CopyButton {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    let text: String
}

extension CopyButton: View {
    var body: some View {
        Button {
            UIPasteboard.general.string = self.text
        } label: {
            if self.hSizeClass == .compact {
                Label("Copy", systemImage: "doc.on.doc")
                    .labelStyle(.iconOnly)
            } else {
                Label("Copy", systemImage: "doc.on.doc")
            }
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
