import SwiftUI

struct ToySection<Title: View, Content: View> {
    let title: Title
    let content: Content

    init(
        _ titleKey: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.title = Text(titleKey)
        self.content = content()
    }

    @_disfavoredOverload
    init<S: StringProtocol>(
        _ title: S,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.title = Text(title)
        self.content = content()
    }

    init<Toolbar: View>(
        _ titleKey: LocalizedStringKey,
        @ViewBuilder toolbar: () -> Toolbar,
        @ViewBuilder content: () -> Content
    ) where Title == HStack<TupleView<(Text, Spacer, Toolbar)>> {
        self.title = HStack {
            Text(titleKey)
            Spacer()
            toolbar()
        }
        self.content = content()
    }

    @_disfavoredOverload
    init<S: StringProtocol, Toolbar: View>(
        _ title: S,
        @ViewBuilder toolbar: () -> Toolbar,
        @ViewBuilder content: () -> Content
    ) where Title == HStack<TupleView<(Text, Spacer, Toolbar)>> {
        self.title = HStack {
            Text(title)
            Spacer()
            toolbar()
        }
        self.content = content()
    }
}

extension ToySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            self.title
            self.content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ToySection_Previews: PreviewProvider {
    static var previews: some View {
        ToySection("Configuration") {
            ConfigurationRow("foo", systemImage: "pencil") {
                Text("bar")
            }
            ConfigurationRow("foo", systemImage: "brain") {
                Text("bar")
            }
            ConfigurationRow("foo", systemImage: "timer") {
                Text("bar")
            }
        }
    }
}
