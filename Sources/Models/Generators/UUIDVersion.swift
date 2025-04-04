enum UUIDVersion {
    case v1
    case v4
}

extension UUIDVersion: CustomStringConvertible {
    var description: String {
        switch self {
        case .v1: "1"
        case .v4: "4 (GUID)"
        }
    }
}

extension UUIDVersion: Identifiable {
    var id: Self { self }
}

extension UUIDVersion: CaseIterable {}
