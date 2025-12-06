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
                    text: .init(
                        get: { self.state.hexadecimal },
                        set: {
                            self.state.inputType = .hexadecimal
                            self.state.hexadecimal = $0
                            self.state.formatText(of: .hexadecimal)
                        }
                    )
                )
                .focused(self.$focusedField, equals: .hexadecimal)
                self.inputSection(
                    type: .decimal,
                    text: .init(
                        get: { self.state.decimal },
                        set: {
                            self.state.inputType = .decimal
                            self.state.decimal = $0
                            self.state.formatText(of: .decimal)
                        }
                    )
                )
                .focused(self.$focusedField, equals: .decimal)
                self.inputSection(
                    type: .octal,
                    text: .init(
                        get: { self.state.octal },
                        set: {
                            self.state.inputType = .octal
                            self.state.octal = $0
                            self.state.formatText(of: .octal)
                        }
                    )
                )
                .focused(self.$focusedField, equals: .octal)
                self.inputSection(
                    type: .binary,
                    text: .init(
                        get: { self.state.binary },
                        set: {
                            self.state.inputType = .binary
                            self.state.binary = $0
                            self.state.formatText(of: .binary)
                        }
                    )
                )
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
            InputButtons(text: text)
            Divider().fixedSize()
            OutputButtons(text: text.wrappedValue)
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
