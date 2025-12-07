import SwiftUI

struct CopyImageButton {
    let image: UIImage
}

extension CopyImageButton: View {
    var body: some View {
        Button("Copy", systemImage: "doc.on.doc") {
            UIPasteboard.general.image = self.image
        }
        .buttonStyle(.toolbarIconOnly)
        .hoverEffect()
    }
}

struct CopyImageButton_Previews: PreviewProvider {
    static var previews: some View {
        // swift-format-ignore: NeverForceUnwrap
        CopyImageButton(
            image: UIImage(systemName: "rainbow")!
                .applyingSymbolConfiguration(.preferringMulticolor())!
        )
        .previewPresets()
    }
}
