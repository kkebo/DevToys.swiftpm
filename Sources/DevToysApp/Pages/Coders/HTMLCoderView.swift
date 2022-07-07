import Introspect
import SwiftUI

struct HTMLCoderView {
    @ObservedObject var state: HTMLCoderViewState

    init(state: AppState) {
        self.state = state.htmlCoderViewState
    }
}

extension HTMLCoderView: View {
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
        .navigationTitle("HTML Encoder / Decoder")
    }
}

struct HTMLCoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HTMLCoderView(state: .init())
        }
        .navigationViewStyle(.stack)
        .previewPresets()
    }
}
