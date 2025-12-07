import SwiftUI

struct OutputImageButtons {
    let data: Data?
}

extension OutputImageButtons: View {
    var body: some View {
        HStack {
            if let data, let image = UIImage(data: data) {
                ViewImageButton(data: data)
                CopyImageButton(image: image)
                SaveImageButton(image: Image(uiImage: image))
            }
        }
    }
}

struct OutputImageButtons_Previews: PreviewProvider {
    static var previews: some View {
        // swift-format-ignore: NeverForceUnwrap
        let data = Base64Coder.decode(
            "R0lGODlhAQABAIAAAP7//wAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
        )!
        return VStack {
            OutputImageButtons(data: data).environment(\.horizontalSizeClass, .regular)
            OutputImageButtons(data: data).environment(\.horizontalSizeClass, .compact)
        }
        .previewPresets()
    }
}
