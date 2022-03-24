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
        guard let header = String(
            data: try JSONSerialization.data(
                withJSONObject: jwt.header,
                options: [.prettyPrinted, .sortedKeys]
            ),
            encoding: .utf8
        ) else {
            throw JWTDecoderError.headerEncodingError
        }
        guard let payload = String(
            data: try JSONSerialization.data(
                withJSONObject: jwt.body,
                options: [.prettyPrinted, .sortedKeys]
            ),
            encoding: .utf8
        ) else {
            throw JWTDecoderError.payloadEncodingError
        }
        return (header, payload)
    }
}
