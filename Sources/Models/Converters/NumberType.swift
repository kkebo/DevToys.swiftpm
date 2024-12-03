enum NumberType: String {
    case hexadecimal
    case decimal
    case octal
    case binary

    var radix: Int {
        switch self {
        case .hexadecimal: 16
        case .decimal: 10
        case .octal: 8
        case .binary: 2
        }
    }

    var digitsInGroup: Int {
        switch self {
        case .hexadecimal: 4
        case .decimal: 3
        case .octal: 3
        case .binary: 4
        }
    }

    var separator: String {
        switch self {
        case .hexadecimal: " "
        case .decimal: ","
        case .octal: " "
        case .binary: " "
        }
    }
}

extension NumberType: Identifiable {
    var id: Self { self }
}

extension NumberType: CaseIterable {}
