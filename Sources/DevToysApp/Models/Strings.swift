import SwiftUI

struct Strings {
    let shortTitle: String
    let longTitle: String
    let iconName: String
    let boldIcon: Bool
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
        iconName: String,
        boldIcon: Bool = false,
        description: String
    ) {
        self.shortTitle = shortTitle
        self.longTitle = longTitle
        self.iconName = iconName
        self.boldIcon = boldIcon
        self.description = description
    }
}
