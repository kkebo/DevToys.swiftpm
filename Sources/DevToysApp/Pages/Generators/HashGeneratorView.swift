import CryptoKit
import SwiftUI

struct HashGeneratorView {
    @State private var isUppercase = false
    @State private var input = ""
    @State private var isImporterPresented = false

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }

    private func hashInput<F: HashFunction>(type: F.Type) -> String {
        guard !self.input.isEmpty else { return "" }
        guard let data = self.input.data(using: .utf8) else { return "" }
        let output: String = F.hash(data: data).lazy
            .map { String($0, radix: 16) }
            .joined()
        return self.isUppercase ? output.uppercased() : output
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

extension HashGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Uppercase", systemImage: "textformat") {
                    Toggle("", isOn: self.$isUppercase)
                }
            }

            self.inputSection

            VStack(spacing: 10) {
                self.outputSection("MD5", type: Insecure.MD5.self)
                self.outputSection("SHA1", type: Insecure.SHA1.self)
                self.outputSection("SHA256", type: SHA256.self)
                self.outputSection("SHA512", type: SHA512.self)
            }
        }
        .navigationTitle("Hash Generator")
    }

    private var inputSection: some View {
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
                .frame(height: 100)
        }
    }

    private func outputSection<F: HashFunction>(
        _ title: String,
        type: F.Type
    ) -> some View {
        ToySection(title) {
            HStack {
                TextField("", text: .constant(self.hashInput(type: type)))
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .disabled(true)
                Button {
                    UIPasteboard.general.string = self.hashInput(type: type)
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