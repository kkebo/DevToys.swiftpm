import SwiftUI

struct ToyPage<Content: View> {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

extension ToyPage: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    self.content
                }
                .padding()
                .frame(minHeight: proxy.size.height, alignment: .top)
            }
        }
    }
}

struct ToyPage_Previews: PreviewProvider {
    static var previews: some View {
        ToyPage {
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
            ToySection("Configuration 2") {
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
        .previewPresets()
    }
}
