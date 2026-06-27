import SwiftUI

struct ToolbarIconOnlyButtonStyle {
    @ScaledMetric private var iconSize = 20
}

extension ToolbarIconOnlyButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration)
            .labelReservedIconWidth(self.iconSize)
            .labelStyle(.iconOnly)
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
