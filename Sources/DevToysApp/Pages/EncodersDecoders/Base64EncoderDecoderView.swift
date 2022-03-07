import SwiftUI

private enum ConversionMode: String {
    case encode
    case decode
}

extension ConversionMode: Identifiable {
    var id: Self { self }
}

extension ConversionMode: CaseIterable {}

struct Base64EncoderDecoderView {
    @State private var conversionMode = ConversionMode.encode
    @State private var encoding = String.Encoding.utf8
    @State private var input = ""

    private var output: String {
        switch self.conversionMode {
        case .encode:
            return self.input
                .data(using: self.encoding)?
                .base64EncodedString() ?? ""
        case .decode:
            return Data(base64Encoded: self.input)
                .flatMap { .init(data: $0, encoding: self.encoding) }
                ?? ""
        }
    }

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension Base64EncoderDecoderView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Conversion")
                    Text("Select which conversion mode you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$conversionMode) {
                        ForEach(ConversionMode.allCases) {
                            Text(LocalizedStringKey($0.rawValue.capitalized))
                        }
                    }
                }
                ConfigurationRow(systemImage: "textformat") {
                    Text("Encoding")
                    Text("Select which encoding do you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$encoding) {
                        ForEach([String.Encoding.utf8], id: \.self) {
                            Text($0.description)
                        }
                    }
                }
            }

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
                .disabled(self.input.isEmpty)
            } content: {
                TextEditor(text: self.$input)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.body.monospaced())
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .frame(minHeight: 200)
            }
            
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
        .navigationTitle("Base 64 Encoder / Decoder")
    }
}

struct Base64EncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        Base64EncoderDecoderView()
    }
}
