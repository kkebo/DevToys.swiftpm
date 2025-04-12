import SwiftUI

struct ResponsiveStack<Content: View> {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ViewBuilder var content: () -> Content
}

extension ResponsiveStack: View {
    var body: some View {
        self.layout {
            self.content()
        }
    }

    private var layout: AnyLayout {
        if self.hSizeClass == .compact {
            AnyLayout(VStackLayout(spacing: 16))
        } else {
            AnyLayout(HStackLayout(spacing: 16))
        }
    }
}
