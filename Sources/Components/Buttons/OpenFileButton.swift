import SwiftUI

struct OpenFileButton {
    @Binding var text: String
    @State private var isImporterPresented = false
    @State private var fileToBeOpenedWithEncoding: URL?

    var encodingPickerPresented: Binding<Bool> {
        .init(
            get: { self.fileToBeOpenedWithEncoding != nil },
            set: { if !$0 { self.fileToBeOpenedWithEncoding = nil } }
        )
    }

    private func openFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            var enc: String.Encoding = .utf8
            self.text = try .init(contentsOf: url, usedEncoding: &enc)
        } catch CocoaError.fileReadCorruptFile {
            self.fileToBeOpenedWithEncoding = url
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }

    private func openFile(_ url: URL, using encoding: String.Encoding) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            self.text = try String(contentsOf: url, encoding: encoding)
        } catch {
            logger.error("\(error.localizedDescription)")
        }
    }

    private func openUnknownEncodingFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        let firstResult = String.availableStringEncodings.lazy
            .compactMap { try? String(contentsOf: url, encoding: $0) }
            .first
        if let firstResult {
            self.text = firstResult
        } else {
            let error = CocoaError(.fileReadCorruptFile) as NSError
            logger.error("\(error.localizedDescription)")
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
        .alert(
            "Choose Character Encoding",
            isPresented: self.encodingPickerPresented,
            presenting: self.fileToBeOpenedWithEncoding
        ) { url in
            Button("Shift_JIS") {
                self.openFile(url, using: .shiftJIS)
            }
            Button("EUC-JP") {
                self.openFile(url, using: .japaneseEUC)
            }
            Button("ISO-2022-JP") {
                self.openFile(url, using: .iso2022JP)
            }
            Button("ASCII") {
                self.openFile(url, using: .ascii)
            }
            Button("Non-lossy ASCII") {
                self.openFile(url, using: .nonLossyASCII)
            }
            Button("Automatic") {
                self.openUnknownEncodingFile(url)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct OpenFileButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenFileButton(text: .constant(""))
            .previewPresets()
    }
}
