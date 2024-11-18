enum JSONIndentation {
    case twoSpaces
    case fourSpaces
    case oneTab
    case minified
}

extension JSONIndentation: CustomStringConvertible {
    var description: String {
        switch self {
        case .twoSpaces: "2 spaces"
        case .fourSpaces: "4 spaces"
        case .oneTab: "1 tab"
        case .minified: "Minified"
        }
    }
}

extension JSONIndentation: Identifiable {
    var id: Self { self }
}

extension JSONIndentation: CaseIterable {}
