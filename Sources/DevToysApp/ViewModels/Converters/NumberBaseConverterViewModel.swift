import Combine

final class NumberBaseConverterViewModel {
    @Published var isFormatOn = true
    @Published var inputType = NumberType.decimal
    @Published var input = ""
    @Published private var inputValue: UInt = 0
    @Published var hexadecimal = ""
    @Published var decimal = ""
    @Published var octal = ""
    @Published var binary = ""

    init() {
        self.$input
            .combineLatest(self.$inputType)
            .dropFirst()
            .map { .init($0, radix: $1.radix) ?? 0 }
            .assign(to: &self.$inputValue)

        let inputWithOptions = self.$inputValue
            .combineLatest(self.$isFormatOn)

        inputWithOptions
            .map { Self.convert($0, into: .hexadecimal, formatted: $1) }
            .assign(to: &self.$hexadecimal)
        inputWithOptions
            .map { Self.convert($0, into: .decimal, formatted: $1) }
            .assign(to: &self.$decimal)
        inputWithOptions
            .map { Self.convert($0, into: .octal, formatted: $1) }
            .assign(to: &self.$octal)
        inputWithOptions
            .map { Self.convert($0, into: .binary, formatted: $1) }
            .assign(to: &self.$binary)
    }

    private static func convert<T: BinaryInteger>(
        _ value: T,
        into type: NumberType,
        uppercase: Bool = true,
        formatted: Bool = false
    ) -> String {
        if formatted {
            return .init(value, radix: type.radix, uppercase: uppercase)
                .reversed()
                .enumerated()
                .reduce(into: "") { acc, cur in
                    let (i, c) = cur
                    if i > 0 && i.isMultiple(of: type.digitsInGroup) {
                        acc = String(c) + type.separator + acc
                    } else {
                        acc = String(c) + acc
                    }
                }
        } else {
            return .init(value, radix: type.radix, uppercase: uppercase)
        }
    }
}

extension NumberBaseConverterViewModel: ObservableObject {}
