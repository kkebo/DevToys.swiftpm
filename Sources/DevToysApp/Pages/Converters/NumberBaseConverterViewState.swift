import Combine

final class NumberBaseConverterViewState {
    @Published var converter = NumberBaseConverter() {
        didSet { self.updateOutputValues() }
    }
    @Published var inputType = NumberType.decimal {
        didSet {
            switch self.inputType {
            case .hexadecimal: self.input = self.hexadecimal
            case .decimal: self.input = self.decimal
            case .octal: self.input = self.octal
            case .binary: self.input = self.binary
            }
        }
    }
    @Published var input = "" {
        didSet { self.updateInputValue() }
    }
    @Published var inputValue: Int? {
        didSet { self.updateOutputValues() }
    }
    @Published var hexadecimal = ""
    @Published var decimal = ""
    @Published var octal = ""
    @Published var binary = ""

    private func updateInputValue() {
        guard !self.input.hasPrefix("-") || self.inputType == .decimal else {
            self.inputValue = nil
            return
        }
        self.inputValue = .init(
            String(self.input.filter { !$0.isWhitespace && $0 != "," }),
            radix: self.inputType.radix
        )
    }

    private func updateOutputValues() {
        if let value = self.inputValue {
            self.hexadecimal = self.converter.convert(
                value,
                to: .hexadecimal
            )
            self.decimal = self.converter.convert(value, to: .decimal)
            self.octal = self.converter.convert(value, to: .octal)
            self.binary = self.converter.convert(value, to: .binary)
        } else {
            self.hexadecimal = ""
            self.decimal = ""
            self.octal = ""
            self.binary = ""
        }
    }
}

extension NumberBaseConverterViewState: ObservableObject {}
