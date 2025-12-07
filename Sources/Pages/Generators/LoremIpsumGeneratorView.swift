import SwiftUI

struct LoremIpsumGeneratorView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Bindable private var state: LoremIpsumGeneratorViewState
    @FocusState private var isFocused: Bool

    init(state: AppState) {
        self.state = state.loremIpsumGeneratorViewState
    }
}

extension LoremIpsumGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow(systemImage: "text.alignleft") {
                    Text("Type")
                    Text("Generate words, sentences or paragraphs of Lorem Ipsum")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$state.generator.type) {
                        ForEach(LoremIpsumType.allCases) {
                            Text(LocalizedStringKey($0.rawValue.capitalized))
                        }
                    }
                    .labelsHidden()
                }
                ConfigurationRow(systemImage: "number") {
                    Text("Length")
                    Text("Number of words, sentences or paragraphs to generate")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    TextField("", text: self.$state.lengthString)
                        .frame(maxWidth: 80)
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .monospacedDigit()
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused(self.$isFocused)
                        .onChange(of: self.isFocused) { _, newValue in
                            if !newValue {
                                self.state.commitLength()
                            }
                        }
                    Stepper(
                        "",
                        value: self.$state.length,
                        in: 1...Int(Int32.max)
                    )
                    .labelsHidden()
                }
                ConfigurationRow(
                    "Start with '\(LoremIpsumGenerator.loremIpsumPrefix)...'",
                    systemImage: "gearshape"
                ) {
                    Toggle("", isOn: self.$state.generator.startWithLoremIpsum)
                        .tint(.accentColor)
                        .labelsHidden()
                }
            }

            ToySection("Output") {
                Button("Refresh", systemImage: "arrow.clockwise") {
                    self.state.generate()
                }
                .buttonStyle(.toolbar)
                .hoverEffect()
                OutputButtons(text: self.state.output)
            } content: {
                CodeEditor(text: .constant(self.state.output))
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle(Tool.loremIpsumGenerator.strings.localizedLongTitle)
    }
}

struct LoremIpsumGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoremIpsumGeneratorView(state: .init())
        }
        .previewPresets()
    }
}
