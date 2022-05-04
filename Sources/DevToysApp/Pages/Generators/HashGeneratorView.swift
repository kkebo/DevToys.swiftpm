import Introspect
import SwiftUI

struct HashGeneratorView {
    @ObservedObject var state: HashGeneratorViewState
}

extension HashGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Uppercase", systemImage: "textformat") {
                    Toggle("", isOn: self.$state.generator.isUppercase)
                        .fixedSize(horizontal: true, vertical: false)
                        .disabled(self.state.generator.outputType != .hex)
                }
                ConfigurationRow(
                    "Output Type",
                    systemImage: "slider.horizontal.3"
                ) {
                    Picker("", selection: self.$state.generator.outputType) {
                        ForEach(HashOutputType.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                }
            }

            self.inputSection

            VStack(spacing: 10) {
                self.outputSection("MD5", value: self.state.md5)
                self.outputSection("SHA1", value: self.state.sha1)
                self.outputSection("SHA256", value: self.state.sha256)
                self.outputSection("SHA512", value: self.state.sha512)
            }
        }
        .navigationTitle("Hash Generator")
    }

    private var inputSection: some View {
        ToySection("Input") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            TextEditor(text: self.$state.input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(height: 100)
                .introspectTextView { textView in
                    textView.backgroundColor = .clear
                }
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
        HashGeneratorView(state: .init())
            .previewPresets()
    }
}
