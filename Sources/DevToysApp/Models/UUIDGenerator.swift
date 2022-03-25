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

#if TESTING_ENABLED
import Darwin
import PlaygroundTester

@objcMembers
final class UUIDGeneratorTests: TestCase {
    func testGenerateV4() {
        let generator = UUIDGenerator()
        AssertNotNil(UUID(uuidString: generator.generate(count: 1)[0]))
    }

    func testGenerateV4Count() {
        let generator = UUIDGenerator()
        AssertEqual(3, other: generator.generate(count: 3).count)
    }

    func testGenerateV4NoHyphens() {
        var generator = UUIDGenerator()
        generator.usesHyphens = false
        let uuid = generator.generate(count: 1).first
        AssertNotNil(uuid)
        Assert(uuid?.contains("-") == false)
    }

    func testGenerateV4Uppercased() {
        var generator = UUIDGenerator()
        generator.isUppercase = true
        let uuid = generator.generate(count: 1).first
        AssertNotNil(uuid)
        AssertEqual(uuid, other: uuid?.uppercased())
    }

    func testGenerateV4NoHyphensAndUppercased() {
        var generator = UUIDGenerator()
        generator.usesHyphens = false
        generator.isUppercase = true
        let uuid = generator.generate(count: 1).first
        AssertNotNil(uuid)
        Assert(uuid?.contains("-") == false)
        AssertEqual(uuid, other: uuid?.uppercased())
    }
}
#endif
