import Introspect
import SwiftUI

struct JSONFormatterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ObservedObject var state: JSONFormatterViewState

    init(state: AppState) {
        self.state = state.jsonFormatterViewState
    }
}

extension JSONFormatterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker(
                        "",
                        selection: self.$state.formatter.indentation
                    ) {
                        ForEach(JSONIndentation.allCases) {
                            Text(LocalizedStringKey($0.description))
                        }
                    }
                }
            }

            if self.hSizeClass == .compact {
                self.inputSection
                self.outputSection
            } else {
                HStack {
                    self.inputSection
                    Divider()
                    self.outputSection
                }
            }
        }
        .navigationTitle(Tool.jsonFormatter.strings.localizedLongTitle)
    }

    private var inputSection: some View {
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
    }

    private var outputSection: some View {
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
}

struct JSONFormatterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JSONFormatterView(state: .init())
        }
        .previewPresets()
    }
}
