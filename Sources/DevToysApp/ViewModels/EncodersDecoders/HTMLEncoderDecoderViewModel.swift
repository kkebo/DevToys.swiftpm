import Combine
import HTMLEntities

final class HTMLEncoderDecoderViewModel {
    @Published var encodeMode = true
    @Published var input = ""
    @Published var output = ""
    
    init() {
        self.$input.combineLatest(self.$encodeMode)
            .dropFirst()
            .map { input, encodeMode in
                encodeMode
                ? Self.encode(input)
                : Self.decode(input)
            }
            .assign(to: &self.$output)
    }
    
    private static func encode(_ input: String) -> String {
        input.htmlEscape(useNamedReferences: true)
    }
    
    private static func decode(_ input: String) -> String {
        input.htmlUnescape()
    }
}

extension HTMLEncoderDecoderViewModel: ObservableObject {}
