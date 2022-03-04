import SwiftUI

struct JSONYAMLConverterView {
    @State var input = ""
    @State var output = ""
}

extension JSONYAMLConverterView: View {
    var body: some View {
        VStack(spacing: 16) {
            ConfigurationSection {
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

            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Input")
                        Spacer()
                        Button {
                            self.input = UIPasteboard.general.string ?? ""
                        } label: {
                            Label("Paste", systemImage: "doc.on.clipboard")
                        }
                        Button {
                            self.input.removeAll()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    TextEditor(text: self.$input)
                }
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        Text("Output")
                        Spacer()
                        Button {
                            UIPasteboard.general.string = self.output
                        } label: {
                            Label("Copy", systemImage: "doc.on.doc")
                        }
                    }
                    TextEditor(text: self.$output)
                }
            }
        }
        .padding()
        .navigationTitle("JSON <> YAML Converter")
    }
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONYAMLConverterView()
    }
}
