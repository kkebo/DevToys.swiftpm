#if DEBUG
    import Logging
    import LoggingPlayground

    import class Foundation.ProcessInfo

    let logger = Logger(label: "main")
#else
    import os.log

    let logger = Logger()
#endif

func initializeLogger() {
    #if DEBUG
        // Use swift-log-playground only if running on Swift Playground or Xcode Previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
        }
    #endif
}
