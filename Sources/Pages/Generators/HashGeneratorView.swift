import SwiftUI

struct HashGeneratorView {
    @Bindable private var state: HashGeneratorViewState

    init(state: AppState) {
        self.state = state.hashGeneratorViewState
    }
}

extension HashGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Uppercase", systemImage: "textformat") {
                    Toggle("", isOn: self.$state.generator.isUppercase)
                        .labelsHidden()
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
                    .labelsHidden()
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
        .navigationTitle(Tool.hashGenerator.strings.localizedLongTitle)
    }

    @MainActor
    private var inputSection: some View {
        ToySection("Input") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            CodeEditor(text: self.$state.input)
                .frame(height: 100)
        }
    }

    private func outputSection(
        _ title: String,
        value: String
    ) -> some View {
        ToySection(title) {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(value)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 2)
                }
                .padding(6)
                .background(.regularMaterial)
                .cornerRadius(8)
                .fontDesign(.monospaced)
                CopyButton(text: value)
            }
        }
    }
}

struct HashGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HashGeneratorView(state: .init())
        }
        .previewPresets()
    }
}
