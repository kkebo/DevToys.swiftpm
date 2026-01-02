import HTMLEntityCoder

struct HTMLCoder {
    static func encode(_ input: String) -> String {
        encodeHTML(input)
    }

    static func decode(_ input: String) -> String {
        decodeHTML(input)
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
