import Combine

@MainActor
final class NumberBaseConverterViewState {
    @Published var converter = NumberBaseConverter() {
        didSet { self.formatAllText() }
    }
    @Published var inputType = NumberType.decimal
    @Published private(set) var inputValue: Int? {
        didSet { self.updateOutputValues() }
    }
    @Published var hexadecimal = "" {
        didSet {
            if self.inputType == .hexadecimal {
                self.updateInputValue(from: self.hexadecimal)
            }
        }
    }
    @Published var decimal = "" {
        didSet {
            if self.inputType == .decimal {
                self.updateInputValue(from: self.decimal)
            }
        }
    }
    @Published var octal = "" {
        didSet {
            if self.inputType == .octal {
                self.updateInputValue(from: self.octal)
            }
        }
    }
    @Published var binary = "" {
        didSet {
            if self.inputType == .binary {
                self.updateInputValue(from: self.binary)
            }
        }
    }

    var input: String {
        switch self.inputType {
        case .hexadecimal: return self.hexadecimal
        case .decimal: return self.decimal
        case .octal: return self.octal
        case .binary: return self.binary
        }
    }

    private func updateInputValue(from input: String) {
        guard !input.hasPrefix("-") || self.inputType == .decimal else {
            self.inputValue = nil
            return
        }
        self.inputValue = .init(
            String(input.filter { !$0.isWhitespace && $0 != "," }),
            radix: self.inputType.radix
        )
    }

    private func updateOutputValues() {
        switch (self.inputValue, self.inputType) {
        case (let value?, .hexadecimal):
            self.decimal = self.converter.convert(value, to: .decimal)
            self.octal = self.converter.convert(value, to: .octal)
            self.binary = self.converter.convert(value, to: .binary)
        case (let value?, .decimal):
            self.hexadecimal = self.converter.convert(
                value,
                to: .hexadecimal
            )
            self.octal = self.converter.convert(value, to: .octal)
            self.binary = self.converter.convert(value, to: .binary)
        case (let value?, .octal):
            self.hexadecimal = self.converter.convert(
                value,
                to: .hexadecimal
            )
            self.decimal = self.converter.convert(value, to: .decimal)
            self.binary = self.converter.convert(value, to: .binary)
        case (let value?, .binary):
            self.hexadecimal = self.converter.convert(
                value,
                to: .hexadecimal
            )
            self.decimal = self.converter.convert(value, to: .decimal)
            self.octal = self.converter.convert(value, to: .octal)
        case (.none, .hexadecimal):
            self.decimal.removeAll()
            self.octal.removeAll()
            self.binary.removeAll()
        case (.none, .decimal):
            self.hexadecimal.removeAll()
            self.octal.removeAll()
            self.binary.removeAll()
        case (.none, .octal):
            self.hexadecimal.removeAll()
            self.decimal.removeAll()
            self.binary.removeAll()
        case (.none, .binary):
            self.hexadecimal.removeAll()
            self.decimal.removeAll()
            self.octal.removeAll()
        }
    }

    func formatText(of type: NumberType) {
        guard let inputValue else { return }
        switch type {
        case .hexadecimal:
            self.hexadecimal = self.converter.convert(
                inputValue,
                to: .hexadecimal
            )
        case .decimal:
            self.decimal = self.converter.convert(inputValue, to: .decimal)
        case .octal:
            self.octal = self.converter.convert(inputValue, to: .octal)
        case .binary:
            self.binary = self.converter.convert(inputValue, to: .binary)
        }
    }

    private func formatAllText() {
        guard let inputValue else { return }
        self.hexadecimal = self.converter.convert(inputValue, to: .hexadecimal)
        self.decimal = self.converter.convert(inputValue, to: .decimal)
        self.octal = self.converter.convert(inputValue, to: .octal)
        self.binary = self.converter.convert(inputValue, to: .binary)
    }
}

extension NumberBaseConverterViewState: ObservableObject {}
