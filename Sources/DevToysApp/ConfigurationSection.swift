import SwiftUI

struct ConfigurationSection<Content: View> {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

extension ConfigurationSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Configuration").font(.title3)
            self.content
        }
    }
}

struct ConfigurationSection_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationSection {
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
