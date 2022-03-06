import SwiftUI

struct JSONYAMLConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @State private var input = ""
    @State private var output = ""

    init() {
        UITextView.appearance().backgroundColor = .clear
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
            Button {
                self.input = UIPasteboard.general.string ?? ""
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
            Button(role: .destructive) {
                self.input.removeAll()
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
        } content: {
            TextEditor(text: self.$input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(minHeight: 200)
        }
    }

    private var outputSection: some View {
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
                .frame(minHeight: 200)
        }
    }
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONYAMLConverterView()
    }
}
