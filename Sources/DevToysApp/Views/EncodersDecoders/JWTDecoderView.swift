import SwiftUI

struct JWTDecoderView {
    @ObservedObject private var viewModel: JWTDecoderViewModel

    init(viewModel: JWTDecoderViewModel) {
        self.viewModel = viewModel

        Task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension JWTDecoderView: View {
    var body: some View {
        ToyPage {
            self.inputSection
            self.headerSection
            self.payloadSection
        }
        .navigationTitle("JWT Decoder")
    }

    private var inputSection: some View {
        ToySection("JWT Token") {
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
                .frame(height: 100)
        }
    }

    private var headerSection: some View {
        ToySection("Header") {
            CopyButton(text: self.viewModel.header)
        } content: {
            TextEditor(text: .constant(self.viewModel.header))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }

    private var payloadSection: some View {
        ToySection("Payload") {
            CopyButton(text: self.viewModel.payload)
        } content: {
            TextEditor(text: .constant(self.viewModel.payload))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }
}

struct JWTDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        JWTDecoderView(viewModel: .init())
    }
}
