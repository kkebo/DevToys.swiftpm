import SwiftUI

struct HashGeneratorView {
    @Bindable private var state: HashGeneratorViewState

    init(state: AppState) {
        self.state = state.hashGeneratorViewState
    }
}

@MainActor
extension HashGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "brain") {
                    Text("Hashing Algorithm")
                    Text("Select which hashing algorithm you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$state.generator.algorithm) {
                        ForEach(HashAlgorithm.allCases) {
                            Text($0.rawValue.uppercased())
                        }
                    }
                }
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

            ToySection("Secret key to use to generate a HMAC hash") {
                InputButtons(text: self.$state.generator.hmacKey)
            } content: {
                TextField("", text: self.$state.generator.hmacKey)
                    .modifier(ClearButtonModifier(text: self.$state.generator.hmacKey))
            }

            self.outputSection
        }
        .navigationTitle(Tool.hashGenerator.strings.localizedLongTitle)
    }

    private var inputSection: some View {
        ToySection("Input") {
            InputButtons(text: self.$state.input)
        } content: {
            CodeEditor(text: self.$state.input)
                .frame(height: 100)
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            OutputButtons(text: self.state.output)
        } content: {
            ScrollView(.horizontal, showsIndicators: false) {
                Text(self.state.output)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
            }
            .padding(6)
            .background(.regularMaterial)
            .cornerRadius(8)
            .fontDesign(.monospaced)
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
