import SwiftUI

private enum ConversionMode: String {
    case encode
    case decode
}

extension ConversionMode: Identifiable {
    var id: Self { self }
}

extension ConversionMode: CaseIterable {}

struct URLEncoderDecoderView {
    @State private var conversionMode = ConversionMode.encode
    @State private var input = ""

    var output: String {
        switch self.conversionMode {
        case .encode:
            return self.input
                .addingPercentEncoding(
                    withAllowedCharacters: .urlQueryAllowed
                        .subtracting(
                            .init(charactersIn: ":#[]@!$&'()*+,;=")
                        )
                ) ?? ""
        case .decode:
            return self.input.removingPercentEncoding ?? ""
        }
    }

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension URLEncoderDecoderView: View {
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
        .navigationTitle("URL Encoder / Decoder")
        .task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

struct URLEncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        URLEncoderDecoderView()
    }
}
