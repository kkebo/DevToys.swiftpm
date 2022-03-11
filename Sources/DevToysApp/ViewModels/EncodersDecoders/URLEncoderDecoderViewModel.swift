import Combine

final class URLEncoderDecoderViewModel {
    @Published var encodeMode = true
    @Published var input = ""
    @Published var output = ""

    init() {
        self.$input
            .combineLatest(self.$encodeMode)
            .dropFirst()
            .map { input, encodeMode in
                encodeMode ? Self.encode(input) : Self.decode(input)
            }
            .replaceNil(with: "")
            .assign(to: &self.$output)
    }

    private static func encode(_ input: String) -> String? {
        input.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(
                    .init(charactersIn: ":#[]@!$&'()*+,;=")
                )
        )
    }

    private static func decode(_ input: String) -> String? {
        input.removingPercentEncoding
    }
}

extension URLEncoderDecoderViewModel: ObservableObject {}
