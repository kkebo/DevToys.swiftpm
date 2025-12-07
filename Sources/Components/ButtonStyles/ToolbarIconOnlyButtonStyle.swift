import SwiftUI

private struct ToolbarIconOnlyButtonLabelStyle {
    @ScaledMetric private var iconSize = 20
}

extension ToolbarIconOnlyButtonLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.icon.frame(width: self.iconSize, height: self.iconSize)
    }
}

struct ToolbarIconOnlyButtonStyle {}

extension ToolbarIconOnlyButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .labelStyle(ToolbarIconOnlyButtonLabelStyle())
            .buttonStyle(.bordered)
    }
}

extension PrimitiveButtonStyle where Self == ToolbarIconOnlyButtonStyle {
    static var toolbarIconOnly: Self { .init() }
}

struct ToolbarIconOnlyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Copy", systemImage: "doc.on.doc") {}
            .buttonStyle(.toolbarIconOnly)
            .previewPresets()
    }
}
