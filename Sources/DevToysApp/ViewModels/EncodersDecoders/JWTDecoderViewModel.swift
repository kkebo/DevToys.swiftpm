import Combine
import JWTDecode
import class Foundation.DispatchQueue
import class Foundation.JSONSerialization

final class JWTDecoderViewModel {
    @Published var input = "" {
        didSet { self.updateDecodedJWT() }
    }
    @Published var decodedJWT: JWT? {
        didSet { self.updateHeaderAndPayload() }
    }
    @Published var header = ""
    @Published var payload = ""

    private func updateDecodedJWT() {
        self.decodedJWT = try? Self.decode(self.input)
    }

    private func updateHeaderAndPayload() {
        if let jwt = self.decodedJWT {
            self.header = (try? Self.encodeHeader(of: jwt)) ?? ""
            self.payload = (try? Self.encodePayload(of: jwt)) ?? ""
        } else {
            self.header = ""
            self.payload = ""
        }
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
