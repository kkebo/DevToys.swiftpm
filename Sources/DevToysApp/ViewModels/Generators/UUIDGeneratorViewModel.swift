import Combine
import struct Foundation.UUID

final class UUIDGeneratorViewModel {
    @Published var usesHyphens = true
    @Published var isUppercase = false
    @Published var version = UUIDVersion.v4
    @Published var numberOfUUIDsString = "1"
    @Published var numberOfUUIDs: UInt?
    @Published var output = ""

    init() {
        self.$numberOfUUIDsString
            .map(UInt.init)
            .assign(to: &self.$numberOfUUIDs)
    }

    func generate() -> String {
        switch self.version {
        case .v1:
            preconditionFailure("not implemented")
        case .v4:
            return Self.generateUUIDv4(
                count: self.numberOfUUIDs ?? 0,
                uppercase: self.isUppercase,
                hyphens: self.usesHyphens
            )
        }
    }

    private static func generateUUIDv4(
        count: UInt,
        uppercase: Bool,
        hyphens: Bool
    ) -> String {
        var uuids = (0..<count).lazy
            .map { _ in UUID().uuidString }
            .joined(separator: "\n")
        if !uppercase {
            uuids = uuids.lowercased()
        }
        if !hyphens {
            uuids = uuids.split(separator: "-").joined()
        }
        return uuids
    }
}

extension UUIDGeneratorViewModel: ObservableObject {}
