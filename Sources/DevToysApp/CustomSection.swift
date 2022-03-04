import SwiftUI

struct CustomSection<Title: View, Content: View> {
    let title: Title
    let content: Content

    init(
        _ titleKey: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.title = Text(titleKey).font(.title3)
        self.content = content()
    }
    
    init<S: StringProtocol>(
        _ title: S,
        @ViewBuilder content: () -> Content
    ) where Title == Text {
        self.title = Text(title).font(.title3)
        self.content = content()
    }

    init<Toolbar: View>(
        _ titleKey: LocalizedStringKey,
        @ViewBuilder toolbar: () -> Toolbar,
        @ViewBuilder content: () -> Content
    ) where Title == HStack<TupleView<(Text, Spacer, Toolbar)>> {
        self.title = HStack {
            Text(titleKey).font(.title3)
            Spacer()
            toolbar()
        }
        self.content = content()
    }

    init<S: StringProtocol, Toolbar: View>(
        _ title: S,
        @ViewBuilder toolbar: () -> Toolbar,
        @ViewBuilder content: () -> Content
    ) where Title == HStack<TupleView<(Text, Spacer, Toolbar)>> {
        self.title = HStack {
            Text(title).font(.title3)
            Spacer()
            toolbar()
        }
        self.content = content()
    }
}

extension CustomSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            self.title
            self.content
        }
    }
}

struct CustomSection_Previews: PreviewProvider {
    static var previews: some View {
        CustomSection("Configuration") {
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
