import SwiftUI

struct OpenInNewWindowButton {
    let tool: Tool
}

extension OpenInNewWindowButton: View {
    var body: some View {
        Button {
            let activity = NSUserActivity(
                activityType: "xyz.kebo.DevToysForiPad.newWindow"
            )
            try! activity.setTypedPayload(
                NewWindowActivityPayload(tool: self.tool)
            )
            let options = UIWindowScene.ActivationRequestOptions()
            options.preferredPresentationStyle = .prominent
            UIApplication.shared.requestSceneSessionActivation(
                nil,
                userActivity: activity,
                options: options
            )
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
