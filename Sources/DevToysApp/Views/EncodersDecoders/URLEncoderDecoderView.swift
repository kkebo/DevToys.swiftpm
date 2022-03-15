import SwiftUI

struct URLEncoderDecoderView {
    @StateObject private var viewModel = URLEncoderDecoderViewModel()

    init() {
        Task { @MainActor in
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
                    Picker("", selection: self.$viewModel.encodeMode) {
                        Text("Encode").tag(true)
                        Text("Decode").tag(false)
                    }
                }
            }

            ToySection("Input") {
                PasteButton(text: self.$viewModel.input)
                OpenFileButton(text: self.$viewModel.input)
                ClearButton(text: self.$viewModel.input)
            } content: {
                TextEditor(text: self.$viewModel.input)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.body.monospaced())
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .frame(idealHeight: 200)
            }

            ToySection("Output") {
                CopyButton(text: self.viewModel.output)
            } content: {
                TextEditor(text: .constant(self.viewModel.output))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .font(.body.monospaced())
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle("URL Encoder / Decoder")
    }
}

struct URLEncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        URLEncoderDecoderView()
    }
}
