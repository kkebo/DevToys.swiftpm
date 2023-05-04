import SwiftUI

struct ExportIPAButton {
    @State private var ipaURL: URL?
}

extension ExportIPAButton: View {
    var body: some View {
        if let ipaURL {
            ShareLink("Share IPA", item: ipaURL)
        } else {
            Button {
                withAnimation {
                    self.ipaURL = try? exportIPA()
                }
            } label: {
                Label("Generate IPA", systemImage: "doc.badge.plus")
            }
        }
    }
}

struct ExportIPAButton_Previews: PreviewProvider {
    static var previews: some View {
        ExportIPAButton()
            .previewPresets()
    }
}
