import SwiftUI

struct Base64ImageCoderView {
    @Bindable private var state: Base64ImageCoderViewState

    init(state: AppState) {
        self.state = state.base64ImageCoderViewState
    }
}

extension Base64ImageCoderView: View {
    var body: some View {
        ToyPage {
            ResponsiveStack(spacing: 16) {
                ToySection("Base64 text") {
                    PasteButton(text: self.$state.text)
                    OpenFileButton(text: self.$state.text)
                    ClearButton(text: self.$state.text)
                } content: {
                    CodeEditor(text: self.$state.text)
                        .frame(idealHeight: 200)
                }
                ToySection("Image preview") {
                    // TODO: Implement
                    // CopyButton
                    // SaveFileButton
                } content: {
                    Group {
                        if let data = self.state.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image).resizable().scaledToFit()
                        } else {
                            ContentUnavailableView("No Image", systemImage: "photo")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(idealHeight: 200)
                    .background(.regularMaterial)
                    .cornerRadius(8)
                }
            }
        }
        .navigationTitle(Tool.base64ImageCoder.strings.localizedLongTitle)
    }
}

struct Base64ImageCoderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Base64ImageCoderView(state: .init())
        }
        .previewPresets()
    }
}
