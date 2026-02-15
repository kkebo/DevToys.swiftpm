#if DEBUG
    import Logging
    import LoggingPlayground

    import class Foundation.Bundle

    let logger = Logger(label: "main")
#else
    import os.log

    let logger = Logger()
#endif

func initializeLogger() {
    #if DEBUG
        if Bundle.main.isPlayground {
            LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
        }
    #endif
}
