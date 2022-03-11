import SwiftUI

struct Base64EncoderDecoderView {
    @State private var encodeMode = true
    @State private var encoding = String.Encoding.utf8
    @State private var input = ""
    @State private var isImporterPresented = false

    private var output: String {
        if self.encodeMode {
            return self.input
                .data(using: self.encoding)?
                .base64EncodedString() ?? ""
        } else {
            return Data(base64Encoded: self.input)
                .flatMap { .init(data: $0, encoding: self.encoding) }
                ?? ""
        }
    }

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

extension Base64EncoderDecoderView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Conversion")
                    Text("Select which conversion mode you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$encodeMode) {
                        Text("Encode").tag(true)
                        Text("Decode").tag(false)
                    }
                }
                ConfigurationRow(systemImage: "textformat") {
                    Text("Encoding")
                    Text("Select which encoding do you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$encoding) {
                        ForEach([String.Encoding.utf8], id: \.self) {
                            Text($0.description)
                        }
                    }
                }
            }

            ToySection("Input") {
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
                    .frame(idealHeight: 200)
            }
            
            ToySection("Output") {
                Button {
                    UIPasteboard.general.string = self.output
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            } content: {
                TextEditor(text: .constant(self.output))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.body.monospaced())
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle("Base 64 Encoder / Decoder")
    }
}

struct Base64EncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        Base64EncoderDecoderView()
    }
}
