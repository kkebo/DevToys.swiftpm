import SwiftUI

struct Sidebar {}

extension Sidebar: View {
    var body: some View {
        List {
            Section("Converters") {
                NavigationLink("JSON <> YAML") {
                    JSONYAMLConverterView()
                }
            }
            Section("Encoders / Decoders") {}
            Section("Formatters") {}
            Section("Generators") {}
            Section("Text") {}
            Section("Graphic") {}
        }
        .navigationTitle("DevToys")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
