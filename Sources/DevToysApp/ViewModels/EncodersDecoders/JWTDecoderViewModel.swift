import Combine
import JWTDecode
import class Foundation.DispatchQueue
import class Foundation.JSONSerialization

final class JWTDecoderViewModel {
    @Published var input = ""
    @Published var header = ""
    @Published var payload = ""

    init() {
        let jwtPublisher = self.$input
            .dropFirst()
            .map { try? Self.decode($0) }

        jwtPublisher
            .map { try? $0.flatMap(Self.encodeHeader) }
            .replaceNil(with: "")
            .assign(to: &self.$header)

        jwtPublisher
            .map { try? $0.flatMap(Self.encodePayload) }
            .replaceNil(with: "")
            .assign(to: &self.$payload)
    }

    private static func decode(_ jwt: String) throws -> JWT {
        try JWTDecode.decode(jwt: jwt)
    }

    private static func encodeHeader(of jwt: JWT) throws -> String? {
        .init(
            data: try JSONSerialization.data(
                withJSONObject: jwt.header,
                options: [.prettyPrinted, .sortedKeys]
            ),
            encoding: .utf8
        )
    }

    private static func encodePayload(of jwt: JWT) throws -> String? {
        .init(
            data: try JSONSerialization.data(
                withJSONObject: jwt.body,
                options: [.prettyPrinted, .sortedKeys]
            ),
            encoding: .utf8
        )
    }
}

extension JWTDecoderViewModel: ObservableObject {}
