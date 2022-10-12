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
            CodeEditor(text: self.$state.input)
                .frame(height: 100)
        }
    }

    private var headerSection: some View {
        ToySection("Header") {
            CopyButton(text: self.state.header)
        } content: {
            CodeEditor(text: .constant(self.state.header))
                .frame(idealHeight: 200)
        }
    }

    private var payloadSection: some View {
        ToySection("Payload") {
            CopyButton(text: self.state.payload)
        } content: {
            CodeEditor(text: .constant(self.state.payload))
                .frame(idealHeight: 200)
        }
    }
}

struct JWTDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JWTDecoderView(state: .init())
        }
        .navigationViewStyle(.stack)
        .previewPresets()
    }
}
