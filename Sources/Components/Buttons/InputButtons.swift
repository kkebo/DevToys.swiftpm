import SwiftUI

struct InputButtons {
    @Binding var text: String
}

extension InputButtons: View {
    var body: some View {
        HStack {
            PasteButton(text: self.$text)
            OpenFileButton(text: self.$text)
            ClearButton(text: self.$text)
        }
    }
}

struct InputButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputButtons(text: .constant("")).environment(\.horizontalSizeClass, .regular)
            InputButtons(text: .constant("")).environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
