enum JSONYAMLConversionMode {
    case yamlToJSON
    case jsonToYAML
}

extension JSONYAMLConversionMode: CaseIterable {}

extension JSONYAMLConversionMode: CustomStringConvertible {
    var description: String {
        switch self {
        case .yamlToJSON: "YAML to JSON"
        case .jsonToYAML: "JSON to YAML"
        }
    }
}
