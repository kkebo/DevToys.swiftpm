import SwiftUI

struct SaveFileButton {
    let text: String
}

extension SaveFileButton: View {
    var body: some View {
        ShareLink(item: self.text)
            .buttonStyle(.toolbarIconOnly)
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
