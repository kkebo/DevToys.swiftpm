import SwiftUI

private enum NumberType: String {
    case hexadecimal
    case decimal
    case octal
    case binary

    var radix: Int {
        switch self {
        case .hexadecimal: return 16
        case .decimal: return 10
        case .octal: return 8
        case .binary: return 2
        }
    }

    var digitsInGroup: Int {
        switch self {
        case .hexadecimal: return 4
        case .decimal: return 3
        case .octal: return 3
        case .binary: return 4
        }
    }

    var separator: String {
        switch self {
        case .hexadecimal: return " "
        case .decimal: return ","
        case .octal: return " "
        case .binary: return " "
        }
    }
}

extension NumberType: Identifiable {
    var id: Self { self }
}

extension NumberType: CaseIterable {}

extension String {
    fileprivate init<T: BinaryInteger>(
        _ value: T,
        type: NumberType = .decimal,
        uppercase: Bool = false,
        formatted: Bool = false
    ) {
        if formatted {
            self = .init(value, radix: type.radix, uppercase: uppercase)
                .reversed()
                .enumerated()
                .reduce(into: "") { acc, cur in
                    let (i, c) = cur
                    if i > 0 && c != "-" && i.isMultiple(of: type.digitsInGroup) {
                        acc = String(c) + type.separator + acc
                    } else {
                        acc = String(c) + acc
                    }
                }
        } else {
            self.init(value, radix: type.radix, uppercase: uppercase)
        }
    }
}

struct NumberBaseConverterView {
    @State private var isFormatOn = true
    @State private var inputType = NumberType.decimal
    @State private var inputString = ""

    private var inputValue: Int {
        .init(self.inputString, radix: self.inputType.radix) ?? 0
    }

    private func outputValue(in type: NumberType) -> String {
        .init(
            self.inputValue,
            type: type,
            uppercase: true,
            formatted: self.isFormatOn
        )
    }
}

extension NumberBaseConverterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Format number", systemImage: "textformat") {
                    Toggle("", isOn: self.$isFormatOn)
                        .tint(.accentColor)
                }
                ConfigurationRow(systemImage: "arrow.left.arrow.right") {
                    Text("Input type")
                    Text("Select which Input type you want to use")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$inputType) {
                        ForEach(NumberType.allCases) { type in
                            Text(LocalizedStringKey(type.rawValue.capitalized))
                        }
                    }
                }
            }

            ToySection("Input") {
                Button {
                    self.inputString = UIPasteboard.general.string ?? ""
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            } content: {
                TextField("Input", text: self.$inputString)
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }

            VStack(spacing: 10) {
                ForEach(NumberType.allCases, content: self.outputSection)
            }
        }
        .navigationTitle("Number Base Converter")
        .task { @MainActor in
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }

    private func outputSection(type: NumberType) -> some View {
        ToySection(type.rawValue.capitalized) {
            HStack {
                TextField("", text: .constant(self.outputValue(in: type)))
                    .textFieldStyle(.roundedBorder)
                    .font(.body.monospaced())
                    .disabled(true)
                Button {
                    UIPasteboard.general.string = self.outputValue(in: type)
                } label: {
                    Image(systemName: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            }
        }
    } 
}

struct NumberBaseConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NumberBaseConverterView()
    }
}
