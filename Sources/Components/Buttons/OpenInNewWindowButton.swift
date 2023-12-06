import SwiftUI

struct OpenInNewWindowButton {
    @Environment(\.openWindow) private var openWindow
    let tool: Tool
}

extension OpenInNewWindowButton: View {
    var body: some View {
        Button {
            self.openWindow(value: self.tool)
        } label: {
            Label("Open in New Window", systemImage: "rectangle.badge.plus")
        }
    }
}

struct OpenInNewWindowButton_Previews: PreviewProvider {
    static var previews: some View {
        OpenInNewWindowButton(tool: .jsonYAMLConverter)
            .previewPresets()
    }
}
