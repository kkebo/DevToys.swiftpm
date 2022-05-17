import typealias Darwin.uuid_t
import struct Foundation.UUID

private extension UUID {
    static func timeBased() -> Self {
        let ptr = UnsafeMutablePointer<uuid_t>.allocate(capacity: 1)
        defer { ptr.deallocate() }
        ptr.withMemoryRebound(
            to: UInt8.self,
            capacity: MemoryLayout<uuid_t>.size
        ) {
            uuid_generate_time($0)
        }
        return .init(uuid: ptr.pointee)
    }
}

struct UUIDGenerator {
    var usesHyphens = true
    var isUppercase = false
    var version = UUIDVersion.v4

    func generate(count: UInt) -> [String] {
        let range: LazySequence<Range<UInt>> = (0..<count).lazy
        var uuids: LazyMapSequence<Range<UInt>, String>
        switch self.version {
        case .v1:
            uuids = range.map { _ in UUID.timeBased().uuidString }
        case .v4:
            uuids = range.map { _ in UUID().uuidString }
        }

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
    func testGenerateV1() {
        var generator = UUIDGenerator()
        generator.version = .v1
        AssertNotNil(UUID(uuidString: generator.generate(count: 1)[0]))
    }

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
