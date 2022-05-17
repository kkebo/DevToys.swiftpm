import Introspect
import SwiftUI

struct NumberBaseConverterView {
    @ObservedObject var state: NumberBaseConverterViewState
}

extension NumberBaseConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Format number", systemImage: "textformat") {
                    Toggle("", isOn: self.$state.converter.isFormatOn)
                        .tint(.accentColor)
                        .fixedSize(horizontal: true, vertical: false)
                }
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Input type")
                    Text("Select which Input type you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$state.inputType) {
                        ForEach(NumberType.allCases) {
                            Text(LocalizedStringKey($0.rawValue.capitalized))
                        }
                    }
                }
            }

            if !self.state.input.isEmpty && self.state.inputValue == nil {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                    Text("The current value isn't valid")
                    Spacer()
                }
                .padding()
                .background(.yellow.opacity(0.2))
                .cornerRadius(8)
            }

            ToySection("Input") {
                PasteButton(text: self.$state.input)
            } content: {
                TextField("", text: self.$state.input)
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .introspectTextField { textField in
                        textField.clearButtonMode = .whileEditing
                    }
            }

            VStack(spacing: 10) {
                self.outputSection(
                    "Hexadecimal",
                    value: self.state.hexadecimal
                )
                self.outputSection(
                    "Decimal",
                    value: self.state.decimal
                )
                self.outputSection("Octal", value: self.state.octal)
                self.outputSection("Binary", value: self.state.binary)
            }
        }
        .navigationTitle(
            Tool.numberBaseConverter.strings.localizedLongTitle
        )
    }

    private func outputSection(
        _ title: LocalizedStringKey,
        value: String
    ) -> some View {
        ToySection(title) {
            HStack {
                TextField("", text: .constant(value))
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .disabled(true)
                CopyButton(text: value)
            }
        }
    } 
}

struct NumberBaseConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NumberBaseConverterView(state: .init())
        }
        .previewPresets()
    }
}
