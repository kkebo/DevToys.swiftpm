import struct Foundation.UUID

struct UUIDGenerator {
    var usesHyphens = true
    var isUppercase = false
    var version = UUIDVersion.v4

    func generate(count: UInt) -> [String] {
        switch self.version {
        case .v1: preconditionFailure("not implemented")
        case .v4: return self.generateV4(count: count)
        }
    }

    func generateV4(count: UInt) -> [String] {
        var uuids = (0..<count).lazy
            .map { _ in UUID().uuidString }
        if !self.isUppercase {
            uuids = uuids.map { $0.lowercased() }
        }
        if !self.usesHyphens {
            uuids = uuids.map { $0.split(separator: "-").joined() }
        }
        return .init(uuids)
    }
}
