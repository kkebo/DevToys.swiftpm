import QuickLook
import SwiftUI

struct ViewImageButton {
    let data: Data
    @State private var imageURL: URL?
    @State private var isSavingFailed = false
}

extension ViewImageButton: View {
    var body: some View {
        Button("View", systemImage: "eye") {
            if let url = CIImage(data: self.data)?.cgImage?.save() {
                self.imageURL = url
            } else {
                self.isSavingFailed = true
            }
        }
        .buttonStyle(.toolbar)
        .hoverEffect()
        .quickLookPreview(self.$imageURL)
        .alert("Failed to view an image", isPresented: self.$isSavingFailed) {}
    }
}

struct ViewImageButton_Previews: PreviewProvider {
    static var previews: some View {
        // swift-format-ignore: NeverForceUnwrap
        let data = Base64Coder.decode(
            "R0lGODlhAQABAIAAAP7//wAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
        )!
        return VStack {
            ViewImageButton(data: data).environment(\.horizontalSizeClass, .regular)
            ViewImageButton(data: data).environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
