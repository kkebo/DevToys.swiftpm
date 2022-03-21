import SwiftUI

struct NumberBaseConverterView {
    @ObservedObject private var viewModel: NumberBaseConverterViewModel

    init(viewModel: NumberBaseConverterViewModel) {
        self.viewModel = viewModel

        Task { @MainActor in
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }
}

extension NumberBaseConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Format number", systemImage: "textformat") {
                    Toggle("", isOn: self.$viewModel.isFormatOn)
                        .tint(.accentColor)
                }
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Input type")
                    Text("Select which Input type you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$viewModel.inputType) {
                        ForEach(NumberType.allCases) {
                            Text(LocalizedStringKey($0.rawValue.capitalized))
                        }
                    }
                }
            }

            if !self.viewModel.input.isEmpty && self.viewModel.inputValue == nil {
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
                PasteButton(text: self.$viewModel.input)
            } content: {
                TextField("", text: self.$viewModel.input)
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }

            VStack(spacing: 10) {
                self.outputSection(
                    "Hexadecimal",
                    value: self.viewModel.hexadecimal
                )
                self.outputSection(
                    "Decimal",
                    value: self.viewModel.decimal
                )
                self.outputSection("Octal", value: self.viewModel.octal)
                self.outputSection("Binary", value: self.viewModel.binary)
            }
        }
        .navigationTitle("Number Base Converter")
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
        NumberBaseConverterView(viewModel: .init())
    }
}
