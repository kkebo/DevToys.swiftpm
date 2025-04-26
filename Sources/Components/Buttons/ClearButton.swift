import SwiftUI

struct ClearButton {
    @Binding var text: String
    @ScaledMetric private var iconSize = 20
}

extension ClearButton: View {
    var body: some View {
        Button(role: .destructive) {
            self.text.removeAll()
        } label: {
            Label {
                Text("Clear")
            } icon: {
                Image(systemName: "xmark").frame(width: self.iconSize, height: self.iconSize)
            }
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
