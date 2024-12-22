import Logging
import LoggingPlayground
import SwiftUI

let logger = Logger(label: "main")

@main
struct DevToysApp {
    init() {
        LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
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
