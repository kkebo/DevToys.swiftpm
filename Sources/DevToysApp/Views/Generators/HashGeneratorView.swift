import SwiftUI

struct HashGeneratorView {
    @StateObject private var viewModel = HashGeneratorViewModel()
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

extension HashGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Uppercase", systemImage: "textformat") {
                    Toggle("", isOn: self.$viewModel.isUppercase)
                }
            }

            self.inputSection

            VStack(spacing: 10) {
                self.outputSection("MD5", value: self.viewModel.md5)
                self.outputSection("SHA1", value: self.viewModel.sha1)
                self.outputSection("SHA256", value: self.viewModel.sha256)
                self.outputSection("SHA512", value: self.viewModel.sha512)
            }
        }
        .navigationTitle("Hash Generator")
    }

    private var inputSection: some View {
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
                .frame(height: 100)
        }
    }

    private func outputSection(
        _ title: String,
        value: String
    ) -> some View {
        ToySection(title) {
            HStack {
                TextField("", text: .constant(value))
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .disabled(true)
                Button {
                    UIPasteboard.general.string = value
                } label: {
                    Image(systemName: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            }
        }
    }
}

struct HashGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        HashGeneratorView()
    }
}
