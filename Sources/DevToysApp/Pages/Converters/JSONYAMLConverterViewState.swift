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
        self.output = (try? JSONYAMLConverter.convert(self.input, mode: self.conversionMode)) ?? ""
    }
}

extension JSONYAMLConverterViewState: ObservableObject {}
