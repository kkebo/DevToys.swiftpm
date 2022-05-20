import SwiftUI

struct BoldModifier {
    @Environment(\.font) private var font
}

extension BoldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font((self.font ?? .body).bold())
    }
}

extension View {
    func bold() -> some View {
        self.modifier(BoldModifier())
    }
}

struct BoldModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Image(systemName: "globe")
            Image(systemName: "globe").bold()
        }
        .imageScale(.large)
    }
}
