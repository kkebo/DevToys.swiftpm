import SwiftUI

struct JSONFormatterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @StateObject private var viewModel = JSONFormatterViewModel()

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension JSONFormatterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: self.$viewModel.indentation) {
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
        .navigationTitle("JSON Formatter")
    }

    private var inputSection: some View {
        ToySection("Input") {
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
                .frame(idealHeight: 200)
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.viewModel.output)
        } content: {
            TextEditor(text: .constant(self.viewModel.output))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }
}

struct JSONFormatterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONFormatterView()
    }
}
