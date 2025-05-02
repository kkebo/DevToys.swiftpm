import SwiftUI

struct SaveFileButton {
    let text: String
    @ScaledMetric private var iconSize = 20
}

extension SaveFileButton: View {
    var body: some View {
        ShareLink(item: self.text) {
            Label {
                Text("Share")
            } icon: {
                Image(systemName: "square.and.arrow.up")
                    .frame(width: self.iconSize, height: self.iconSize)
            }
            .labelStyle(.iconOnly)
        }
        .buttonStyle(.bordered)
        .hoverEffect()
        .disabled(self.text.isEmpty)
    }
}

struct SaveFileButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveFileButton(text: "hello")
            .previewPresets()
    }
}
