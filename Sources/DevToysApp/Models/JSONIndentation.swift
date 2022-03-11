enum JSONIndentation {
    case twoSpaces
    case fourSpaces
    case oneTab
    case minified
}

extension JSONIndentation: CustomStringConvertible {
    var description: String {
        switch self {
        case .twoSpaces: return "2 spaces"
        case .fourSpaces: return "4 spaces"
        case .oneTab: return "1 tab"
        case .minified: return "Minified"
        }
    }
}

extension JSONIndentation: Identifiable {
    var id: Self { self }
}

extension JSONIndentation: CaseIterable {}
