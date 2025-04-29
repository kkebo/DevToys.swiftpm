import Logging
import LoggingPlayground
import SwiftUI

let logger = Logger(label: "main")

@main
struct DevToysApp {
    init() {
        // Use swift-log-playground only if running on Swift Playground or Xcode Previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
        }
    }
}

extension DevToysApp: App {
    var body: some Scene {
        WindowGroup {
            StandaloneContentView()
        }

        WindowGroup(for: Tool.self) { $tool in
            ContentView(tool: $tool)
        }
    }
}
