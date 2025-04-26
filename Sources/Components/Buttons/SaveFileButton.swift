import SwiftUI

struct SaveFileButton {
    let text: String
}

extension SaveFileButton: View {
    var body: some View {
        ShareLink(item: self.text)
            .labelStyle(.iconOnly)
            .buttonStyle(.bordered)
            .hoverEffect()
    }
}

struct SaveFileButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveFileButton(text: "hello")
            .previewPresets()
    }
}
