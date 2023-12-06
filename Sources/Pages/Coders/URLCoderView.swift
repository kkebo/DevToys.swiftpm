import SwiftUI

struct URLCoderView {
    @ObservedObject var state: URLCoderViewState

    init(state: AppState) {
        self.state = state.urlCoderViewState
    }
}

extension URLCoderView: View {
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
                CodeEditor(text: self.$state.input)
                    .frame(idealHeight: 200)
            }

            ToySection("Output") {
                CopyButton(text: self.state.output)
            } content: {
                CodeEditor(text: .constant(self.state.output))
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle("URL Encoder / Decoder")
    }
}

struct URLCoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            URLCoderView(state: .init())
        }
        .previewPresets()
    }
}
