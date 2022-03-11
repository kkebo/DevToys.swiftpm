import SwiftUI

struct Base64EncoderDecoderView {
    @StateObject private var viewModel = Base64EncoderDecoderViewModel()
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
            self.viewModel.input = try .init(contentsOf: url)
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
                    Picker("", selection: self.$viewModel.encodeMode) {
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
                    Picker("", selection: self.$viewModel.encoding) {
                        Text("UTF-8").tag(String.Encoding.utf8)
                        Text("ASCII").tag(String.Encoding.ascii)
                    }
                }
            }

            ToySection("Input") {
                Button {
                    self.viewModel.input = UIPasteboard.general.string ?? ""
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
                    self.viewModel.input.removeAll()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
                .disabled(self.viewModel.input.isEmpty)
            } content: {
                TextEditor(text: self.$viewModel.input)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.body.monospaced())
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .frame(idealHeight: 200)
            }
            
            ToySection("Output") {
                Button {
                    UIPasteboard.general.string = self.viewModel.output
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            } content: {
                TextEditor(text: .constant(self.viewModel.output))
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
