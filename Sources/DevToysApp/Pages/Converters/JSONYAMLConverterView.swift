import SwiftUI

struct JSONYAMLConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ObservedObject private var state: JSONYAMLConverterViewState

    init(state: AppState) {
        self.state = state.jsonYAMLConverterViewState
    }
}

extension JSONYAMLConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Conversion")
                    Text("Select which conversion mode you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$state.conversionMode) {
                        ForEach(JSONYAMLConversionMode.allCases, id: \.self) {
                            Text(LocalizedStringKey($0.description))
                        }
                    }
                    .labelsHidden()
                }
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: .constant(0)) {
                        Text("2 spaces").tag(0)
                    }
                    .labelsHidden()
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
        .navigationTitle(Tool.jsonYAMLConverter.strings.localizedLongTitle)
    }

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

    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.state.output)
        } content: {
            CodeEditor(text: .constant(self.state.output))
                .frame(idealHeight: 200)
        }
    }
}

struct JSONYAMLConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            JSONYAMLConverterView(state: .init())
        }
        .previewPresets()
    }
}
