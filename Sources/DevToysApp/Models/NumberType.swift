enum NumberType: String {
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
