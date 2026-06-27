import SwiftUI

struct ToolbarButtonStyle {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ScaledMetric private var iconSize = 20
}

extension ToolbarButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if self.hSizeClass == .compact {
            Button(configuration)
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
        } else {
            Button(configuration)
                .labelStyle(.titleAndIcon)
                .buttonStyle(.bordered)
        }
    }
}

extension PrimitiveButtonStyle where Self == ToolbarButtonStyle {
    static var toolbar: Self { .init() }
}

struct ToolbarButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Copy", systemImage: "doc.on.doc") {}
                .environment(\.horizontalSizeClass, .regular)
            Button("Copy", systemImage: "doc.on.doc") {}
                .environment(\.horizontalSizeClass, .compact)
        }
        .buttonStyle(.toolbar)
        .previewPresets()
    }
}
