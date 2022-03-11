import SwiftUI

struct URLEncoderDecoderView {
    @State private var encodeMode = true
    @State private var input = ""
    @State private var isImporterPresented = false

    private var output: String {
        if self.encodeMode {
            return self.input
                .addingPercentEncoding(
                    withAllowedCharacters: .urlQueryAllowed
                        .subtracting(
                            .init(charactersIn: ":#[]@!$&'()*+,;=")
                        )
                ) ?? ""
        } else {
            return self.input.removingPercentEncoding ?? ""
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

extension URLEncoderDecoderView: View {
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
        .navigationTitle("URL Encoder / Decoder")
    }
}

struct URLEncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        URLEncoderDecoderView()
    }
}
