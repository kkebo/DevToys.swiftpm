import SwiftUI

struct OutputButtons {
    let text: String
}

extension OutputButtons: View {
    var body: some View {
        HStack {
            SaveFileButton(text: self.text)
            CopyButton(text: self.text)
        }
    }
}

struct OutputButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OutputButtons(text: "").environment(\.horizontalSizeClass, .regular)
            OutputButtons(text: "").environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
