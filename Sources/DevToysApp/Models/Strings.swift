import SwiftUI

struct Strings {
    let shortTitle: String
    let longTitle: String
    let description: String

    var localizedLongTitle: String {
        NSLocalizedString(self.longTitle, comment: "")
    }

    var localizedDescription: String {
        NSLocalizedString(self.description, comment: "")
    }

    init(
        shortTitle: String,
        longTitle: String,
        description: String
    ) {
        self.shortTitle = shortTitle
        self.longTitle = longTitle
        self.description = description
    }
}
