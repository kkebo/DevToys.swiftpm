import Introspect
import SwiftUI

struct NumberBaseConverterView {
    @FocusState private var focusedField: NumberType?
    @ObservedObject var state: NumberBaseConverterViewState

    init(state: AppState) {
        self.state = state.numberBaseConverterViewState
    }
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
        .navigationTitle(
            Tool.numberBaseConverter.strings.localizedLongTitle
        )
        .onChange(of: self.focusedField) { [focusedField] type in
            if let type = type {
                self.state.inputType = type
            } else if let oldType = focusedField {
                self.state.formatText(of: oldType)
            }
        }
    }

    private func inputSection(
        type: NumberType,
        text: Binding<String>
    ) -> some View {
        ToySection(LocalizedStringKey(type.rawValue.capitalized)) {
            HStack {
                TextField("", text: text)
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .introspectTextField { textField in
                        textField.clearButtonMode = .whileEditing
                    }
                PasteButton(text: text) {
                    self.state.inputType = type
                }
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
