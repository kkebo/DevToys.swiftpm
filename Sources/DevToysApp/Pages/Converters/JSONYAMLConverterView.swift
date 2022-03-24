import SwiftUI

struct JSONYAMLConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @State private var input = ""
    @State private var output = ""

    init() {
        Task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension JSONYAMLConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Conversion")
                    Text("Select which conversion mode you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: .constant(0)) {
                        Text("YAML to JSON")
                        Text("JSON to YAML")
                    }
                }
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: .constant(0)) {
                        Text("2 spaces")
                    }
                }
            }

            if self.hSizeClass == .compact {
                self.inputSection
                self.outputSection
            } else {
                HStack {
                    self.inputSection
                    Divider()
                    self.outputSection
                }
            }
        }
        .navigationTitle("JSON <> YAML Converter")
    }

    private var inputSection: some View {
        ToySection("Input") {
            PasteButton(text: self.$input)
            OpenFileButton(text: self.$input)
            ClearButton(text: self.$input)
        } content: {
            TextEditor(text: self.$input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.output)
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
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONYAMLConverterView()
            .previewPresets()
    }
}
