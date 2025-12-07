import SwiftUI

struct SaveImageButton {
    let image: Image
}

extension SaveImageButton: View {
    var body: some View {
        ShareLink(item: self.image, preview: .init("image", image: self.image))
            .buttonStyle(.toolbarIconOnly)
            .hoverEffect()
    }
}

struct SaveImageButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveImageButton(image: Image(systemName: "rainbow").symbolRenderingMode(.multicolor))
            .previewPresets()
    }
}
