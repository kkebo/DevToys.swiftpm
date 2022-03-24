import SwiftUI

#if TESTING_ENABLED
    import PlaygroundTester
#endif

struct Sidebar {
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject private var state: AppState
    #if TESTING_ENABLED
        @State private var isTesterViewPresented = false
    #endif
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
            #if TESTING_ENABLED
                Button {
                    self.isTesterViewPresented = true
                } label: {
                    Label("Unit Tests", systemImage: "checklist")
                }
                .sheet(isPresented: self.$isTesterViewPresented) {
                    PlaygroundTesterView()
                }
            #endif
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
                NumberBaseConverterView(
                    state: self.state.numberBaseConverterViewState
                )
            } label: {
                Label("Number Base", systemImage: "number.square")
            }
        } header: {
            Text("Converters").font(.title3.bold())
        }
        Section {
            NavigationLink {
                HTMLCoderView(state: self.state.htmlCoderViewState)
            } label: {
                Label(
                    "HTML",
                    systemImage: "chevron.left.slash.chevron.right"
                )
            }
            NavigationLink {
                URLCoderView(state: self.state.urlCoderViewState)
            } label: {
                Label("URL", systemImage: "link")
            }
            NavigationLink {
                Base64CoderView(state: self.state.base64CoderViewState)
            } label: {
                Label("Base 64", systemImage: "b.square")
            }
            NavigationLink {
                JWTDecoderView(state: self.state.jwtDecoderViewState)
            } label: {
                Label {
                    Text("JWT Decoder")
                } icon: {
                    Image(systemName: "rays").font(.body.bold())
                }
            }
        } header: {
            Text("Encoders / Decoders").font(.title3.bold())
        }
        Section {
            NavigationLink {
                JSONFormatterView(state: self.state.jsonFormatterViewState)
            } label: {
                Label("JSON", systemImage: "curlybraces")
            }
        } header: {
            Text("Formatters").font(.title3.bold())
        }
        Section {
            NavigationLink {
                HashGeneratorView(state: self.state.hashGeneratorViewState)
            } label: {
                Label("Hash", systemImage: "number")
            }
            NavigationLink {
                UUIDGeneratorView(state: self.state.uuidGeneratorViewState)
            } label: {
                Label("UUID", systemImage: "01.square")
            }
        } header: {
            Text("Generators").font(.title3.bold())
        }
        Section {
        } header: {
            Text("Text").font(.title3.bold())
        }
        Section {
        } header: {
            Text("Graphic").font(.title3.bold())
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
                NumberBaseConverterView(
                    state: self.state.numberBaseConverterViewState
                )
            } label: {
                Label("Number Base Converter", systemImage: "number.square")
            }
        }
        if self.isMatch("HTML Encoder / Decoder") {
            NavigationLink {
                HTMLCoderView(state: self.state.htmlCoderViewState)
            } label: {
                Label(
                    "HTML Encoder / Decoder",
                    systemImage: "chevron.left.slash.chevron.right"
                )
            }
        }
        if self.isMatch("URL Encoder / Decoder") {
            NavigationLink {
                URLCoderView(state: self.state.urlCoderViewState)
            } label: {
                Label("URL Encoder / Decoder", systemImage: "link")
            }
        }
        if self.isMatch("Base 64 Encoder / Decoder") {
            NavigationLink {
                Base64CoderView(state: self.state.base64CoderViewState)
            } label: {
                Label("Base 64 Encoder / Decoder", systemImage: "b.square")
            }
        }
        if self.isMatch("JWT Decoder") {
            NavigationLink {
                JWTDecoderView(state: self.state.jwtDecoderViewState)
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
                JSONFormatterView(state: self.state.jsonFormatterViewState)
            } label: {
                Label("JSON Formatter", systemImage: "curlybraces")
            }
        }
        if self.isMatch("Hash Generator") {
            NavigationLink {
                HashGeneratorView(state: self.state.hashGeneratorViewState)
            } label: {
                Label("Hash Generator", systemImage: "number")
            }
        }
        if self.isMatch("UUID Generator") {
            NavigationLink {
                UUIDGeneratorView(state: self.state.uuidGeneratorViewState)
            } label: {
                Label("UUID Generator", systemImage: "01.square")
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(searchQuery: "")
            .environmentObject(AppState())
            .previewPresets()
    }
}
