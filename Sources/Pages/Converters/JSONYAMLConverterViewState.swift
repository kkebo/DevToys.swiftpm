import Observation
import UniYAML

@Observable
final class JSONYAMLConverterViewState {
    var conversionMode = JSONYAMLConversionMode.yamlToJSON {
        didSet {
            if oldValue != self.conversionMode {
                self.input = self.output
            }
        }
    }
    var input = "" {
        didSet { self.updateOutput() }
    }
    private(set) var output = ""

    private func updateOutput() {
        self.output = (try? JSONYAMLConverter.convert(self.input, mode: self.conversionMode)) ?? ""
    }
}
