import JWTDecode
import SwiftUI

struct JWTDecoderView {
    @State private var input = ""
    @State private var header = ""
    @State private var payload = ""
    @State private var isImporterPresented = false

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }

    private func openFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            self.input = try .init(contentsOf: url)
        } catch {
            logger.error("\(error.localizedDescription)")
            return
        }
    }
}

extension JWTDecoderView: View {
    var body: some View {
        ToyPage {
            self.inputSection
            self.headerSection
            self.payloadSection
        }
        .navigationTitle("JWT Decoder")
    }

    private var inputSection: some View {
        ToySection("JWT Token") {
            Button {
                self.input = UIPasteboard.general.string ?? ""
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
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
                Image(systemName: "doc")
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
            Button(role: .destructive) {
                self.input.removeAll()
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
            .disabled(self.input.isEmpty)
        } content: {
            TextEditor(text: self.$input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(height: 100)
                .onChange(of: self.input) { input in
                    guard
                        let jwt = try? JWTDecode.decode(jwt: input),
                        let header = try? JSONSerialization.data(
                            withJSONObject: jwt.header,
                            options: [.prettyPrinted, .sortedKeys]
                        ),
                        let payload = try? JSONSerialization.data(
                            withJSONObject: jwt.body,
                            options: [.prettyPrinted, .sortedKeys]
                        )
                    else {
                        self.header = ""
                        self.payload = ""
                        return
                    }
                    self.header = .init(data: header, encoding: .utf8) ?? ""
                    self.payload = .init(data: payload, encoding: .utf8) ?? ""
                }
        }
    }

    private var headerSection: some View {
        ToySection("Header") {
            Button {
                UIPasteboard.general.string = self.header
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
        } content: {
            TextEditor(text: .constant(self.header))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }

    private var payloadSection: some View {
        ToySection("Payload") {
            Button {
                UIPasteboard.general.string = self.payload
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
        } content: {
            TextEditor(text: .constant(self.payload))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }
}

struct JWTDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        JWTDecoderView()
    }
}
