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
            self.text = try .init(contentsOf: url)
        } catch {
            logger.error("\(error.localizedDescription)")
            return
        }
    }
}

extension OpenFileButton: View {
    var body: some View {
        Button {
            if self.isImporterPresented {
                // Workaround for the known issue
                // https://developer.apple.com/forums/thread/693140
                self.isImporterPresented = false
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + .milliseconds(50)
                ) {
                    self.isImporterPresented = true
                }
            } else {
                self.isImporterPresented = true
            }
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
