import SwiftUI

struct HashGeneratorView {
    @StateObject private var viewModel = HashGeneratorViewModel()

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
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
            PasteButton(text: self.$viewModel.input)
            OpenFileButton(text: self.$viewModel.input)
            ClearButton(text: self.$viewModel.input)
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
                CopyButton(text: value)
            }
        }
    }
}

struct HashGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        HashGeneratorView()
    }
}
