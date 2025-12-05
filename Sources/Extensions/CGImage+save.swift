import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

extension CGImage {
    func save() -> URL? {
        guard
            let uti = self.utType,
            let ext = UTType(uti as String)?.preferredFilenameExtension
        else { return nil }
        let url = FileManager.default.temporaryDirectory
            .appending(component: UUID().uuidString + "." + ext)
        guard let destination = CGImageDestinationCreateWithURL(url as CFURL, uti, 1, nil) else {
            return nil
        }
        CGImageDestinationAddImage(destination, self, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        return url
    }
}
