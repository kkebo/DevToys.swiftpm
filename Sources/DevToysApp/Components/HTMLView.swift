import SwiftUI
import WebKit

struct HTMLView {
    private let html: String

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
        uiView.loadHTMLString(self.html, baseURL: nil)
    }
}
