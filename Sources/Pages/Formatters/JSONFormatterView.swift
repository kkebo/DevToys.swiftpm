import SwiftUI

struct JSONFormatterView {
    @Bindable private var state: JSONFormatterViewState

    init(state: AppState) {
        self.state = state.jsonFormatterViewState
    }
}

extension JSONFormatterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: self.$state.formatter.indentation) {
                        ForEach(JSONIndentation.allCases) {
                            Text(LocalizedStringKey($0.description))
                        }
                    }
                    .labelsHidden()
                }
            }

            ResponsiveStack {
                self.inputSection
                self.outputSection
            }
        }
        .navigationTitle(Tool.jsonFormatter.strings.localizedLongTitle)
    }

    @MainActor
    private var inputSection: some View {
        ToySection("Input") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            CodeEditor(text: self.$state.input)
                .frame(idealHeight: 200)
        }
    }

    @MainActor
    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.state.output)
        } content: {
            CodeEditor(text: .constant(self.state.output))
                .frame(idealHeight: 200)
        }
    }
}

struct JSONFormatterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            JSONFormatterView(state: .init())
        }
        .previewPresets()
    }
}
