import QuickLook
import SwiftUI

struct ViewImageButton {
    let data: Data
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ScaledMetric private var iconSize = 20
    @State private var imageURL: URL?
    @State private var isSavingFailed = false
}

extension ViewImageButton: View {
    var body: some View {
        Button {
            if let url = CIImage(data: self.data)?.cgImage?.save() {
                self.imageURL = url
            } else {
                self.isSavingFailed = true
            }
        } label: {
            if self.hSizeClass == .compact {
                self.label.labelStyle(.iconOnly)
            } else {
                self.label
            }
        }
        .buttonStyle(.bordered)
        .hoverEffect()
        .quickLookPreview(self.$imageURL)
        .alert("Failed to view an image", isPresented: self.$isSavingFailed) {}
    }

    private var label: some View {
        Label {
            Text("View")
        } icon: {
            Image(systemName: "eye")
                .frame(
                    width: self.hSizeClass == .compact ? self.iconSize : nil,
                    height: self.iconSize
                )
        }
        .lineLimit(1)
    }
}

struct ViewImageButton_Previews: PreviewProvider {
    static var previews: some View {
        // swift-format-ignore: NeverForceUnwrap
        let data = Base64Coder.decode(
            "R0lGODlhAQABAIAAAP7//wAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
        )!
        return ViewImageButton(data: data)
            .previewPresets()
    }
}
