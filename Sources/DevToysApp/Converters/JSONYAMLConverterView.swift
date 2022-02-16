import SwiftUI

struct JSONYAMLConverterView {
    @State var input = ""
    @State var output = ""
}

extension JSONYAMLConverterView: View {
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Configuration")
                Label {
                    VStack(alignment: .leading) {
                        Text("Conversion")
                        Text("Select which conversion mode you want to use")
                            .foregroundStyle(.secondary)
                    }
                } icon: {
                    Image(systemName: "arrow.left.arrow.right")
                }
                Label("Indentation", systemImage: "increase.indent")
            }
            .frame(maxWidth: .infinity, alignment: .leading)

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
