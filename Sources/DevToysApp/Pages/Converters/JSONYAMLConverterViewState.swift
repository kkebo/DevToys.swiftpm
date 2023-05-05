import Combine
import UniYAML

@MainActor
final class JSONYAMLConverterViewState {
    @Published var conversionMode = JSONYAMLConversionMode.yamlToJSON {
        didSet {
            if oldValue != self.conversionMode {
                self.input = self.output
            }
        }
    }
    @Published var input = "" {
        didSet { self.updateOutput() }
    }
    @Published var output = ""

    private func updateOutput() {
        guard let inputObject = try? UniYAML.decode(self.input) else {
            self.output = ""
            return
        }
        switch self.conversionMode {
        case .yamlToJSON:
            self.output = (try? UniYAML.encode(inputObject, with: .json)) ?? ""
        case .jsonToYAML:
            self.output = (try? UniYAML.encode(inputObject, with: .yaml)) ?? ""
        }
    }
}

extension JSONYAMLConverterViewState: ObservableObject {}
