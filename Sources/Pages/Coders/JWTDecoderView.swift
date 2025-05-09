import SwiftUI

struct JWTDecoderView {
    @Bindable private var state: JWTDecoderViewState

    init(state: AppState) {
        self.state = state.jwtDecoderViewState
    }
}

@MainActor
extension JWTDecoderView: View {
    var body: some View {
        ToyPage {
            self.inputSection
            self.headerSection
            self.payloadSection
        }
        .navigationTitle(Tool.jwtDecoder.strings.localizedLongTitle)
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
            SaveFileButton(text: self.state.header)
            CopyButton(text: self.state.header)
        } content: {
            CodeEditor(text: .constant(self.state.header))
                .frame(idealHeight: 200)
        }
    }

    private var payloadSection: some View {
        ToySection("Payload") {
            SaveFileButton(text: self.state.payload)
            CopyButton(text: self.state.payload)
        } content: {
            CodeEditor(text: .constant(self.state.payload))
                .frame(idealHeight: 200)
        }
    }
}

struct JWTDecoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            JWTDecoderView(state: .init())
        }
        .previewPresets()
    }
}
