import SwiftUI

struct Sidebar {
    @Environment(\.isSearching) private var isSearching
    let searchQuery: String

    private func isMatch(_ name: String) -> Bool {
        self.searchQuery.isEmpty
            || name.lowercased().contains(self.searchQuery.lowercased())
    }
}

extension Sidebar: View {
    var body: some View {
        List {
            if !self.isSearching || self.searchQuery.isEmpty {
                self.normalRows
            } else {
                self.searchResults
            }
        }
        .navigationTitle("DevToys")
    }

    @ViewBuilder private var normalRows: some View {
        NavigationLink {
            AllToolsView(searchQuery: self.searchQuery)
        } label: {
            Label("All tools", systemImage: "house")
        }
        Section {
            NavigationLink {
                JSONYAMLConverterView()
            } label: {
                Label("JSON <> YAML", systemImage: "doc.plaintext")
            }
            NavigationLink {
                NumberBaseConverterView()
            } label: {
                Label("Number Base", systemImage: "number.square")
            }
        } header: {
            Label("Converters", systemImage: "arrow.triangle.2.circlepath")
        }
        Section {
            NavigationLink {
                URLEncoderDecoderView()
            } label: {
                Label("URL", systemImage: "link")
            }
            NavigationLink {
                Base64EncoderDecoderView()
            } label: {
                Label("Base 64", systemImage: "b.square")
            }
            NavigationLink {
                JWTDecoderView()
            } label: {
                Label {
                    Text("JWT Decoder")
                } icon: {
                    Image(systemName: "rays").font(.body.bold())
                }
            }
        } header: {
            Label("Encoders / Decoders", systemImage: "01.square")
        }
        Section {
            NavigationLink {
                JSONFormatterView()
            } label: {
                Label("JSON", systemImage: "curlybraces")
            }
        } header: {
            Label("Formatters", systemImage: "increase.indent")
        }
        Section {
            NavigationLink {
                HashGeneratorView()
            } label: {
                Label("Hash", systemImage: "number")
            }
            NavigationLink {
                UUIDGeneratorView()
            } label: {
                Label("UUID", systemImage: "01.square")
            }
        } header: {
            Label("Generators", systemImage: "plus.square")
        }
        Section {
        } header: {
            Label("Text", systemImage: "textformat")
        }
        Section {
        } header: {
            Label("Graphic", systemImage: "photo.on.rectangle.angled")
        }
    }

    @ViewBuilder private var searchResults: some View {
        if self.isMatch("JSON <> YAML Converter") {
            NavigationLink {
                JSONYAMLConverterView()
            } label: {
                Label("JSON <> YAML Converter", systemImage: "doc.plaintext")
            }
        }
        if self.isMatch("Number Base Converter") {
            NavigationLink {
                NumberBaseConverterView()
            } label: {
                Label("Number Base Converter", systemImage: "number.square")
            }
        }
        if self.isMatch("URL Encoder / Decoder") {
            NavigationLink {
                URLEncoderDecoderView()
            } label: {
                Label("URL Encoder / Decoder", systemImage: "link")
            }
        }
        if self.isMatch("Base 64 Encoder / Decoder") {
            NavigationLink {
                Base64EncoderDecoderView()
            } label: {
                Label("Base 64 Encoder / Decoder", systemImage: "b.square")
            }
        }
        if self.isMatch("JWT Decoder") {
            NavigationLink {
                JWTDecoderView()
            } label: {
                Label {
                    Text("JWT Decoder")
                } icon: {
                    Image(systemName: "rays").font(.body.bold())
                }
            }
        }
        if self.isMatch("JSON Formatter") {
            NavigationLink {
                JSONFormatterView()
            } label: {
                Label("JSON Formatter", systemImage: "curlybraces")
            }
        }
        if self.isMatch("Hash Generator") {
            NavigationLink {
                HashGeneratorView()
            } label: {
                Label("Hash Generator", systemImage: "number")
            }
        }
        if self.isMatch("UUID Generator") {
            NavigationLink {
                UUIDGeneratorView()
            } label: {
                Label("UUID Generator", systemImage: "01.square")
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(searchQuery: "")
    }
}
