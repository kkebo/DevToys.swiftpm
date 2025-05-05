import SwiftUI

@main
struct DevToysApp {
    init() {
        initializeLogger()
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
