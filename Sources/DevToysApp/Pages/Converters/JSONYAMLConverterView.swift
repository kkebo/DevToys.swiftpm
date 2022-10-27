import SwiftUI

struct JSONYAMLConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @State private var input = ""
    @State private var output = ""
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
                        Text("YAML to JSON").tag(0)
                        Text("JSON to YAML").tag(1)
                    }
                    .labelsHidden()
                }
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: .constant(0)) {
                        Text("2 spaces").tag(0)
                    }
                    .labelsHidden()
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
        .navigationTitle(Tool.jsonYAMLConverter.strings.localizedLongTitle)
    }

    private var inputSection: some View {
        ToySection("Input") {
            PasteButton(text: self.$input)
            OpenFileButton(text: self.$input)
            ClearButton(text: self.$input)
        } content: {
            CodeEditor(text: self.$input)
                .frame(idealHeight: 200)
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.output)
        } content: {
            CodeEditor(text: .constant(self.output))
                .frame(idealHeight: 200)
        }
    }
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            JSONYAMLConverterView()
        }
        .previewPresets()
    }
}
