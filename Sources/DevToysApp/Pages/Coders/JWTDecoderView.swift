import Introspect
import SwiftUI

struct JWTDecoderView {
    @ObservedObject var state: JWTDecoderViewState

    init(state: AppState) {
        self.state = state.jwtDecoderViewState
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
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            TextEditor(text: self.$state.input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(height: 100)
                .introspectTextView { textView in
                    textView.backgroundColor = .clear
                }
        }
    }

    private var headerSection: some View {
        ToySection("Header") {
            CopyButton(text: self.state.header)
        } content: {
            TextEditor(text: .constant(self.state.header))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
                .introspectTextView { textView in
                    textView.backgroundColor = .clear
                }
        }
    }

    private var payloadSection: some View {
        ToySection("Payload") {
            CopyButton(text: self.state.payload)
        } content: {
            TextEditor(text: .constant(self.state.payload))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
                .introspectTextView { textView in
                    textView.backgroundColor = .clear
                }
        }
    }
}

struct JWTDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JWTDecoderView(state: .init())
        }
        .previewPresets()
    }
}
