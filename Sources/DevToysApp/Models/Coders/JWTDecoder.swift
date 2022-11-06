import JWTDecode

import class Foundation.DispatchQueue
import class Foundation.JSONSerialization

enum JWTDecoderError {
    case headerEncodingError
    case payloadEncodingError
}

extension JWTDecoderError: Error {}

struct JWTDecoder {
    static func decode(
        _ input: String
    ) throws -> (header: String, payload: String) {
        let jwt = try JWTDecode.decode(jwt: input)
        guard
            let header = String(
                data: try JSONSerialization.data(
                    withJSONObject: jwt.header,
                    options: [.prettyPrinted, .sortedKeys]
                ),
                encoding: .utf8
            )
        else {
            throw JWTDecoderError.headerEncodingError
        }
        guard
            let payload = String(
                data: try JSONSerialization.data(
                    withJSONObject: jwt.body,
                    options: [.prettyPrinted, .sortedKeys]
                ),
                encoding: .utf8
            )
        else {
            throw JWTDecoderError.payloadEncodingError
        }
        return (header, payload)
    }
}

#if TESTING_ENABLED
    import PlaygroundTester

    @objcMembers
    final class JWTDecoderTests: TestCase {
        func testDecode() throws {
            let input =
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
            let (header, payload) = try JWTDecoder.decode(input)
            AssertEqual(
                """
                {
                  "alg" : "HS256",
                  "typ" : "JWT"
                }
                """,
                other: header
            )
            AssertEqual(
                """
                {
                  "iat" : 1516239022,
                  "name" : "John Doe",
                  "sub" : "1234567890"
                }
                """,
                other: payload
            )
        }
    }
#endif
