import Observation

@Observable
final class JWTDecoderViewState {
    var input = "" {
        didSet { self.updateHeaderAndPayload() }
    }
    private(set) var header = ""
    private(set) var payload = ""

    private func updateHeaderAndPayload() {
        if let (header, payload) = try? JWTDecoder.decode(self.input) {
            self.header = header
            self.payload = payload
        } else {
            self.header = ""
            self.payload = ""
        }
    }
}
