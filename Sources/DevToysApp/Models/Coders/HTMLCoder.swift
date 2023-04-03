import HTMLEntities

struct HTMLCoder {
    static func encode(_ input: String) -> String {
        input.htmlEscape(useNamedReferences: true)
    }

    static func decode(_ input: String) -> String {
        input.htmlUnescape()
    }
}

#if TESTING_ENABLED
    import Foundation
    import PlaygroundTester

    @objcMembers
    final class HTMLCoderTests: TestCase {
        func testEncode() {
            AssertEqual(
                "&lt;Hello World&gt;",
                other: HTMLCoder.encode("<Hello World>")
            )
        }

        func testDecode() {
            AssertEqual(
                "<Hello World>",
                other: HTMLCoder.decode("&lt;Hello World&gt;")
            )
        }
    }
#endif
