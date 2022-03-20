import Combine

final class NumberBaseConverterViewModel {
    @Published var isFormatOn = true
    @Published var inputType = NumberType.decimal
    @Published var input = ""
    @Published var inputValue: Int?
    @Published var hexadecimal = ""
    @Published var decimal = ""
    @Published var octal = ""
    @Published var binary = ""

    init() {
        self.$input
            .combineLatest(self.$inputType)
            .dropFirst()
            .map(Self.convert)
            .assign(to: &self.$inputValue)

        let inputWithOptions = self.$inputValue
            .combineLatest(self.$isFormatOn)
            .dropFirst()

        inputWithOptions
            .map { value, format in
                value.map {
                    Self.convert($0, to: .hexadecimal, formatted: format)
                } ?? ""
            }
            .assign(to: &self.$hexadecimal)
        inputWithOptions
            .map { value, format in
                value.map {
                    Self.convert($0, to: .decimal, formatted: format)
                } ?? ""
            }
            .assign(to: &self.$decimal)
        inputWithOptions
            .map { value, format in
                value.map {
                    Self.convert($0, to: .octal, formatted: format)
                } ?? ""
            }
            .assign(to: &self.$octal)
        inputWithOptions
            .map { value, format in
                value.map {
                    Self.convert($0, to: .binary, formatted: format)
                } ?? ""
            }
            .assign(to: &self.$binary)
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
