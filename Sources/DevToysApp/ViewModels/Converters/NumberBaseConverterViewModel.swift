import Combine

final class NumberBaseConverterViewModel {
    @Published var isFormatOn = true {
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
        self.inputValue = Self.convert(self.input, from: self.inputType)
    }

    private func updateOutputValues() {
        if let value = self.inputValue {
            let format = self.isFormatOn
            self.hexadecimal = Self.convert(value, to: .hexadecimal, formatted: format)
            self.decimal = Self.convert(value, to: .decimal, formatted: format)
            self.octal = Self.convert(value, to: .octal, formatted: format)
            self.binary = Self.convert(value, to: .binary, formatted: format)
        } else {
            self.hexadecimal = ""
            self.decimal = ""
            self.octal = ""
            self.binary = ""
        }
    }

    private static func convert<S: StringProtocol>(
        _ value: S,
        from type: NumberType
    ) -> Int? {
        guard !value.hasPrefix("-") || type == .decimal else {
            return nil
        }
        return .init(
            String(value.filter { !$0.isWhitespace && $0 != "," }),
            radix: type.radix
        )
    }

    private static func convert(
        _ value: Int,
        to type: NumberType,
        uppercase: Bool = true,
        formatted: Bool = false
    ) -> String {
        let converted: String
        if type != .decimal && value < 0 {
            // 2's complement
            converted = .init(
                UInt(bitPattern: value),
                radix: type.radix,
                uppercase: uppercase
            )
        } else {
            converted = .init(
                value,
                radix: type.radix,
                uppercase: uppercase
            )
        }

        return formatted ? Self.format(converted, type: type) : converted
    }

    private static func format(
        _ value: String,
        type: NumberType
    ) -> String {
        value
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
    }
}

extension NumberBaseConverterViewModel: ObservableObject {}
