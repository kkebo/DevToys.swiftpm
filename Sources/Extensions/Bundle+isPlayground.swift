import class Foundation.Bundle

extension Bundle {
    var isPlayground: Bool {
        self.bundleIdentifier?.hasPrefix("swift-playgrounds-dev") == true
    }

    var isPlaygroundPreview: Bool {
        self.bundleIdentifier?.hasPrefix("swift-playgrounds-dev-previews") == true
    }
}
