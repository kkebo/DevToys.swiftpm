import SwiftUI

private struct ToolbarButtonLabelStyle {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ScaledMetric private var iconSize = 20
}

extension ToolbarButtonLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.frame(width: self.iconSize, height: self.iconSize)
            if self.hSizeClass != .compact {
                configuration.title
            }
        }
    }
}

struct ToolbarButtonStyle {}

extension ToolbarButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .labelStyle(ToolbarButtonLabelStyle())
            .buttonStyle(.bordered)
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
