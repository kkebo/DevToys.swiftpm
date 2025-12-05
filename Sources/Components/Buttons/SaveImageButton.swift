import SwiftUI

struct SaveImageButton {
    let image: Image
    @ScaledMetric private var iconSize = 20
}

extension SaveImageButton: View {
    var body: some View {
        ShareLink(item: self.image, preview: .init("image", image: self.image)) {
            Label {
                Text("Share")
            } icon: {
                Image(systemName: "square.and.arrow.up")
                    .frame(width: self.iconSize, height: self.iconSize)
            }
            .labelStyle(.iconOnly)
        }
        .buttonStyle(.bordered)
        .hoverEffect()
    }
}

struct SaveImageButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveImageButton(image: Image(systemName: "rainbow").symbolRenderingMode(.multicolor))
            .previewPresets()
    }
}
