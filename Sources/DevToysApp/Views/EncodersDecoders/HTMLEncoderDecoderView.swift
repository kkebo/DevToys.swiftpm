import SwiftUI

struct HTMLEncoderDecoderView {
    @ObservedObject private var viewModel: HTMLEncoderDecoderViewModel

    init(viewModel: HTMLEncoderDecoderViewModel) {
        self.viewModel = viewModel

        Task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension HTMLEncoderDecoderView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Conversion")
                    Text("Select which conversion mode you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Toggle(
                        self.viewModel.encodeMode ? "Encode" : "Decode",
                        isOn: self.$viewModel.encodeMode
                    )
                    .tint(.accentColor)
                    .fixedSize(horizontal: true, vertical: false)
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
        .navigationTitle("HTML Encoder / Decoder")
    }
}

struct HTMLEncoderDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLEncoderDecoderView(viewModel: .init())
    }
}
