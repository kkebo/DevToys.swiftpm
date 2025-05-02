import SwiftUI

struct CopyButton {
    let text: String
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ScaledMetric private var iconSize = 20
}

extension CopyButton: View {
    var body: some View {
        Button {
            UIPasteboard.general.string = self.text
        } label: {
            if self.hSizeClass == .compact {
                self.label.labelStyle(.iconOnly)
            } else {
                self.label
            }
        }
        .buttonStyle(.bordered)
        .hoverEffect()
        .disabled(self.text.isEmpty)
    }

    private var label: some View {
        Label {
            Text("Copy")
        } icon: {
            Image(systemName: "doc.on.doc")
                .frame(
                    width: self.hSizeClass == .compact ? self.iconSize : nil,
                    height: self.iconSize
                )
        }
        .lineLimit(1)
    }
}

struct CopyButton_Previews: PreviewProvider {
    static var previews: some View {
        CopyButton(text: "foobar")
            .previewPresets()
    }
}
