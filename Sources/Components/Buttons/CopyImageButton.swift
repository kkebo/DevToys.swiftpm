import SwiftUI

struct CopyImageButton {
    let image: UIImage
    @ScaledMetric private var iconSize = 20
}

extension CopyImageButton: View {
    var body: some View {
        Button {
            UIPasteboard.general.image = self.image
        } label: {
            Label {
                Text("Copy")
            } icon: {
                Image(systemName: "doc.on.doc")
                    .frame(width: self.iconSize, height: self.iconSize)
            }
            .labelStyle(.iconOnly)
        }
        .buttonStyle(.bordered)
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
