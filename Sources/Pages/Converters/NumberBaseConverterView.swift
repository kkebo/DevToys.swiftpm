import SwiftUI

struct NumberBaseConverterView {
    @FocusState private var focusedField: NumberType?
    @Bindable private var state: NumberBaseConverterViewState

    init(state: AppState) {
        self.state = state.numberBaseConverterViewState
    }
}

@MainActor
extension NumberBaseConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Format number", systemImage: "textformat") {
                    Toggle("", isOn: self.$state.converter.isFormatOn)
                        .tint(.accentColor)
                        .labelsHidden()
                }
            }

            if !self.state.input.isEmpty && self.state.inputValue == nil {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                    Text("The current value isn't valid")
                    Spacer()
                }
                .padding()
                .background(.yellow.opacity(0.2))
                .cornerRadius(8)
            }

            VStack(spacing: 10) {
                self.inputSection(
                    type: .hexadecimal,
                    text: self.$state.hexadecimal
                )
                .focused(self.$focusedField, equals: .hexadecimal)
                self.inputSection(type: .decimal, text: self.$state.decimal)
                    .focused(self.$focusedField, equals: .decimal)
                self.inputSection(type: .octal, text: self.$state.octal)
                    .focused(self.$focusedField, equals: .octal)
                self.inputSection(type: .binary, text: self.$state.binary)
                    .focused(self.$focusedField, equals: .binary)
            }
        }
        .navigationTitle(Tool.numberBaseConverter.strings.localizedLongTitle)
        .onChange(of: self.focusedField) { oldValue, newValue in
            if let newValue {
                self.state.inputType = newValue
            }
            if let oldValue {
                self.state.formatText(of: oldValue)
            }
        }
    }

    private func inputSection(
        type: NumberType,
        text: Binding<String>
    ) -> some View {
        ToySection(LocalizedStringKey(type.rawValue.capitalized)) {
            PasteButton(text: text) {
                self.state.inputType = type
            } postAction: {
                self.state.formatText(of: type)
            }
            // TODO: OpenFileButton
            // TODO: ClearButton
            Divider().fixedSize()
            SaveFileButton(text: text.wrappedValue)
            CopyButton(text: text.wrappedValue)
        } content: {
            TextField("", text: text, axis: .vertical)
                .modifier(ClearButtonModifier(text: text))
                .fontDesign(.monospaced)
                .keyboardType(.numbersAndPunctuation)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
    }
}

struct NumberBaseConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NumberBaseConverterView(state: .init())
        }
        .previewPresets()
    }
}
