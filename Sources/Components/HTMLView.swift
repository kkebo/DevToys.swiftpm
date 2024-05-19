import SwiftUI
import WebKit

struct HTMLView {
    private let html: String
    private var fullHTML: String {
        """
        <!doctype html>
        <html>
        <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">
        </head>
        <body>
        \(self.html)
        </body>
        </html>
        """
    }

    init(_ html: String) {
        self.html = html
    }
}

extension HTMLView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    func makeUIView(context: Self.Context) -> Self.UIViewType {
        .init()
    }

    func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) {
        uiView.loadHTMLString(self.fullHTML, baseURL: nil)
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView("<h1>Title</h1><h2>Subtitle</h2>")
            .previewPresets()
    }
}
