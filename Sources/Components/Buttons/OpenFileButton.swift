import SwiftUI

struct OpenFileButton {
    @Binding var text: String
    @State private var isImporterPresented = false

    private func openFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            var enc: String.Encoding = .utf8
            self.text = try .init(contentsOf: url, usedEncoding: &enc)
        } catch {
            logger.error("\(error.localizedDescription)")
            return
        }
    }
}

extension OpenFileButton: View {
    var body: some View {
        Button {
            self.isImporterPresented.toggle()
        } label: {
            Label("Open", systemImage: "doc")
                .labelStyle(.iconOnly)
        }
        .buttonStyle(.bordered)
        .hoverEffect()
        .fileImporter(
            isPresented: self.$isImporterPresented,
            allowedContentTypes: [.data]
        ) {
            switch $0 {
            case .success(let url):
                self.openFile(url)
            case .failure(let error):
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}

struct OpenFileButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenFileButton(text: .constant(""))
            .previewPresets()
    }
}
