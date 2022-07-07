import Introspect
import SwiftUI

struct Base64CoderView {
    @ObservedObject var state: Base64CoderViewState

    init(state: AppState) {
        self.state = state.base64CoderViewState
    }
}

extension Base64CoderView: View {
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
                        self.state.encodeMode ? "Encode" : "Decode",
                        isOn: self.$state.encodeMode
                    )
                    .tint(.accentColor)
                    .fixedSize(horizontal: true, vertical: false)
                }
                ConfigurationRow(systemImage: "textformat") {
                    Text("Encoding")
                    Text("Select which encoding do you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$state.coder.encoding) {
                        Text("UTF-8").tag(String.Encoding.utf8)
                        Text("ASCII").tag(String.Encoding.ascii)
                    }
                }
            }

            ToySection("Input") {
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
                    .frame(idealHeight: 200)
                    .introspectTextView { textView in
                        textView.backgroundColor = .clear
                    }
            }

            ToySection("Output") {
                CopyButton(text: self.state.output)
            } content: {
                TextEditor(text: .constant(self.state.output))
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
        .navigationTitle("Base 64 Encoder / Decoder")
    }
}

struct Base64CoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Base64CoderView(state: .init())
        }
        .navigationViewStyle(.stack)
        .previewPresets()
    }
}
