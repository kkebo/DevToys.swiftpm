import SwiftUI

struct JSONYAMLConverterView {
    @Environment(\.horizontalSizeClass) var hSizeClass
    @State var input = ""
    @State var output = ""

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
}

extension JSONYAMLConverterView: View {
    var body: some View {
        VStack(spacing: 16) {
            CustomSection("Configuration") {
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
                self.inputView
                self.outputView
            } else {
                HStack {
                    self.inputView
                    Divider()
                    self.outputView
                }
            }
        }
        .padding()
        .navigationTitle("JSON <> YAML Converter")
    }

    var inputView: some View {
        CustomSection("Input") {
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
                .background(.regularMaterial)
                .cornerRadius(8)
        }
    }

    var outputView: some View {
        CustomSection("Output") {
            Button {
                UIPasteboard.general.string = self.output
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
        } content: {
            TextEditor(text: self.$output)
                .background(.regularMaterial)
                .cornerRadius(8)
        }
    }
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONYAMLConverterView()
    }
}
