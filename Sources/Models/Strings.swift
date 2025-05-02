import SwiftUI

struct Strings {
    let shortTitle: String
    let longTitle: String
    let description: String

    var localizedLongTitle: String {
        String(localized: .init(self.longTitle))
    }

    var localizedDescription: String {
        String(localized: .init(self.description))
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
