import SwiftUI

struct Base64CoderView {
    @Bindable private var state: Base64CoderViewState

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
                        Text("UTF-8").tag(Base64CoderEncoding.utf8)
                        Text("ASCII").tag(Base64CoderEncoding.ascii)
                    }
                    .labelsHidden()
                }
            }

            ToySection("Input") {
                InputButtons(text: self.$state.input)
            } content: {
                CodeEditor(text: self.$state.input)
                    .frame(idealHeight: 200)
            }

            ToySection("Output") {
                OutputButtons(text: self.state.output)
            } content: {
                CodeEditor(text: .constant(self.state.output))
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle(Tool.base64Coder.strings.localizedLongTitle)
    }
}

struct Base64CoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Base64CoderView(state: .init())
        }
        .previewPresets()
    }
}
