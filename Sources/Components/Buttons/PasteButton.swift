import SwiftUI

struct PasteButton {
    @Binding var text: String
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ScaledMetric private var iconSize = 20
}

extension PasteButton: View {
    var body: some View {
        Button {
            self.text = UIPasteboard.general.string ?? ""
        } label: {
            if self.hSizeClass == .compact {
                self.label.labelStyle(.iconOnly)
            } else {
                self.label
            }
        }
        .buttonStyle(.bordered)
        .hoverEffect()
    }

    private var label: some View {
        Label {
            Text("Paste")
        } icon: {
            Image(systemName: "doc.on.clipboard")
                .frame(
                    width: self.hSizeClass == .compact ? self.iconSize : nil,
                    height: self.iconSize
                )
        }
        .lineLimit(1)
    }
}

struct PasteButton_Previews: PreviewProvider {
    static var previews: some View {
        PasteButton(text: .constant(""))
            .previewPresets()
    }
}
