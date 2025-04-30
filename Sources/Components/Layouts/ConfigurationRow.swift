import SwiftUI

private struct ConfigurationLabelStyle {
    @ScaledMetric private var iconSize = 20
}

extension ConfigurationLabelStyle: LabelStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.icon.frame(width: self.iconSize)
            configuration.title
        }
    }
}

struct ConfigurationRow<Title: View, Content: View> {
    private let label: Label<Title, Image>
    private let content: Content

    init<T: View>(
        systemImage name: String,
        @ViewBuilder title: () -> T,
        @ViewBuilder content: () -> Content
    ) where Title == VStack<T> {
        self.label = Label {
            VStack(alignment: .leading, spacing: 10) {
                title()
            }
        } icon: {
            Image(systemName: name)
        }
        self.content = content()
    }

    init(
        _ titleKey: LocalizedStringKey,
        systemImage name: String,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.label = Label(titleKey, systemImage: name)
        self.content = content()
    }

    @_disfavoredOverload
    init<S: StringProtocol>(
        _ title: S,
        systemImage name: String,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.label = Label(title, systemImage: name)
        self.content = content()
    }
}

extension ConfigurationRow: View {
    var body: some View {
        GroupBox {
            HStack {
                self.label.labelStyle(ConfigurationLabelStyle())
                Spacer()
                self.content
            }
        }
    }
}

struct ConfigurationRow_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationRow("foo", systemImage: "pencil") {
            Text("bar")
        }
        .previewPresets()
    }
}
