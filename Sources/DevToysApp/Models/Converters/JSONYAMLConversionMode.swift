enum JSONYAMLConversionMode {
    case yamlToJSON
    case jsonToYAML
}

extension JSONYAMLConversionMode: CaseIterable {}

extension JSONYAMLConversionMode: CustomStringConvertible {
    var description: String {
        switch self {
        case .yamlToJSON: return "YAML to JSON"
        case .jsonToYAML: return "JSON to YAML"
        }
    }
}
