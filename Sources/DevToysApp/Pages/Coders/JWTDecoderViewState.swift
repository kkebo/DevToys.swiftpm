import Combine

@MainActor
final class JWTDecoderViewState {
    @Published var input = "" {
        didSet { self.updateHeaderAndPayload() }
    }
    @Published var header = ""
    @Published var payload = ""

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

extension JWTDecoderViewState: ObservableObject {}
