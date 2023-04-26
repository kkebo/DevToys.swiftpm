import SwiftUI

struct ClearButtonModifier {
    @FocusState private var isFocused
    @Binding var text: String
}

extension ClearButtonModifier: ViewModifier {
    func body(content: Self.Content) -> some View {
        HStack {
            content
                .focused(self.$isFocused)
            if self.isFocused && !self.text.isEmpty {
                Button {
                    self.text.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.primary)
                        .opacity(0.2)
                }
                .hoverEffect()
            }
        }
        .padding(6)
        .background(.regularMaterial)
        .cornerRadius(8)
    }
}

struct ClearButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        TextField("", text: .constant("text"))
            .modifier(ClearButtonModifier(text: .constant("text")))
            .previewPresets()
    }
}
