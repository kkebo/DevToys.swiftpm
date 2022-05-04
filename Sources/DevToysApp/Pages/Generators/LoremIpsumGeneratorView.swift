import Introspect
import SwiftUI

struct LoremIpsumGeneratorView {
    @ObservedObject var state: LoremIpsumGeneratorViewState
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
                }
                ConfigurationRow(systemImage: "number") {
                    Text("Length")
                    Text("Number of words, sentences or paragraphs to generate")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    TextField(
                        "",
                        value: self.$state.length,
                        format: .number
                    )
                    .frame(width: 80)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .font(.body.monospacedDigit())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .border(!self.state.isLengthValid ? .red : .clear)
                    .onSubmit {
                        if !self.state.isLengthValid {
                            self.state.length = self.state.generator.length
                        }
                    }
                }
                ConfigurationRow(
                    "Start with '\(LoremIpsumGenerator.loremIpsumPrefix)...'",
                    systemImage: "gearshape"
                ) {
                    Toggle("", isOn: self.$state.generator.startWithLoremIpsum)
                        .tint(.accentColor)
                }
            }

            ToySection("Output") {
                CopyButton(text: self.state.output)
                ClearButton(text: self.$state.output)
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
        .navigationTitle("Lorem Ipsum Generator")
    }
}

struct LoremIpsumGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        LoremIpsumGeneratorView(state: .init())
            .previewPresets()
    }
}
