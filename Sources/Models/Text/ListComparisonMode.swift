enum ListComparisonMode {
    case intersection
    case union
    case aOnly
    case bOnly
}

extension ListComparisonMode: CaseIterable {}

extension ListComparisonMode: CustomStringConvertible {
    var description: String {
        switch self {
        case .intersection: "A ∩ B"
        case .union: "A ∪ B"
        case .aOnly: "A Only"
        case .bOnly: "B Only"
        }
    }
}
