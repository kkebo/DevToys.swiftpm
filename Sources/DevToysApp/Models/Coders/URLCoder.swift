struct URLCoder {
    static func encode(_ input: String) -> String? {
        input.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(
                    .init(charactersIn: ":#[]@!$&'()*+,;=")
                )
        )
    }

    static func decode(_ input: String) -> String? {
        input.removingPercentEncoding
    }
}

#if TESTING_ENABLED
    import PlaygroundTester

    @objcMembers
    final class URLCoderTests: TestCase {
        func testEncode() {
            AssertEqual(
                "Hello%20there%20%21",
                other: URLCoder.encode("Hello there !")
            )
        }

        func testDecode() {
            AssertEqual(
                "Hello there !",
                other: URLCoder.decode("Hello%20there%20%21")
            )
        }
    }
#endif
