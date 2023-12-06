import SwiftUI

struct ClearButton {
    @Binding var text: String
}

extension ClearButton: View {
    var body: some View {
        Button(role: .destructive) {
            self.text.removeAll()
        } label: {
            Label("Clear", systemImage: "xmark")
                .labelStyle(.iconOnly)
        }
        .buttonStyle(.bordered)
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
