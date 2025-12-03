import Observation

import struct Foundation.Data

@Observable
final class Base64ImageCoderViewState {
    var text = "" {
        didSet { self.updateOutput() }
    }
    private(set) var imageData: Data?

    private func updateOutput() {
        self.imageData = Base64Coder.decode(self.text)
    }
}
