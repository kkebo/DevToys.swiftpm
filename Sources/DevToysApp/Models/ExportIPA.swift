import Foundation

func exportIPA() throws -> URL {
    let bundleURL = Bundle.main.bundleURL

    let workingDirectory = FileManager.default.temporaryDirectory
        .appending(path: UUID().uuidString)
    let payloadDirectory = workingDirectory.appending(path: "Payload")
    try FileManager.default.createDirectory(
        at: payloadDirectory,
        withIntermediateDirectories: true
    )
    defer {
        try? FileManager.default.removeItem(at: workingDirectory)
    }

    let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "App"
    let appURL = payloadDirectory.appending(path: "\(appName).app")
    try FileManager.default.copyItem(at: bundleURL, to: appURL)

    let bundleID = Bundle.main.bundleIdentifier ?? ""
    let updatedBundleID = bundleID.replacing("swift-playgrounds-", with: "")
    let infoPlistURL = appURL.appending(path: "Info.plist")
    let infoPlist = try NSMutableDictionary(contentsOf: infoPlistURL, error: ())
    if !updatedBundleID.isEmpty {
        infoPlist[kCFBundleIdentifierKey as String] = updatedBundleID
    }
    try infoPlist.write(to: infoPlistURL)

    let ipaURL = FileManager.default.temporaryDirectory
        .appending(path: "\(appName).ipa")
    var error: NSError?
    var internalError: NSError?
    NSFileCoordinator()
        .coordinate(
            readingItemAt: payloadDirectory,
            options: .forUploading,
            error: &error
        ) { url in
            do {
                _ = try FileManager.default.replaceItemAt(ipaURL, withItemAt: url)
            } catch {
                internalError = error as NSError
            }
        }
    if let error {
        throw error
    }
    if let internalError {
        throw internalError
    }

    return ipaURL
}
