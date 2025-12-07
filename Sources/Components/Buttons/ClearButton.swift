import SwiftUI

struct ClearButton {
    @Binding var text: String
}

extension ClearButton: View {
    var body: some View {
        Button("Clear", systemImage: "xmark", role: .destructive) {
            self.text.removeAll()
        }
        .buttonStyle(.toolbarIconOnly)
        .hoverEffect()
        .disabled(self.text.isEmpty)
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton(text: .constant(""))
            .previewPresets()
    }
}
