import SwiftUI

struct ResponsiveStack<Content: View> {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    private let alignment: Alignment
    private let spacing: CGFloat?
    private let content: Content

    init(
        alignment: Alignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }
}

extension ResponsiveStack: View {
    var body: some View {
        self.layout {
            self.content
        }
    }

    private var layout: AnyLayout {
        if self.hSizeClass == .compact {
            AnyLayout(VStackLayout(alignment: self.alignment.horizontal, spacing: self.spacing))
        } else {
            AnyLayout(HStackLayout(alignment: self.alignment.vertical, spacing: self.spacing))
        }
    }
}

struct ResponsiveStack_Previews: PreviewProvider {
    static var previews: some View {
        ResponsiveStack {
            Text("A")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.green)
            Text("B")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
        }
        .previewPresets()
    }
}
