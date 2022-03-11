import SwiftUI

struct Base64EncoderDecoderView {
    @StateObject private var viewModel = Base64EncoderDecoderViewModel()

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
                    Picker("", selection: self.$viewModel.encodeMode) {
                        Text("Encode").tag(true)
                        Text("Decode").tag(false)
                    }
                }
                ConfigurationRow(systemImage: "textformat") {
                    Text("Encoding")
                    Text("Select which encoding do you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$viewModel.encoding) {
                        Text("UTF-8").tag(String.Encoding.utf8)
                        Text("ASCII").tag(String.Encoding.ascii)
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
        .navigationTitle("Base 64 Encoder / Decoder")
    }
}

struct Base64EncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        Base64EncoderDecoderView()
    }
}
