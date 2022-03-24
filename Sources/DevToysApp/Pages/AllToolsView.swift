import SwiftUI

private struct AllToolsLabelStyle {
    @Environment(\.colorScheme) private var colorScheme
}

extension AllToolsLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 50))
                .frame(width: 80, height: 80)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            self.colorScheme == .dark
                                ? Color.secondary.opacity(0.2)
                                : .clear
                        )
                )
                .padding(30)

            VStack {
                configuration.title
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
            .padding([.horizontal, .bottom])
        }
        .frame(minHeight: 300, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.secondary)
                .opacity(self.colorScheme == .dark ? 0.2 : 0.1)
        )
    }
}

struct AllToolsView {
    @Environment(\.isSearching) private var isSearching
    @EnvironmentObject private var state: AppState
    let searchQuery: String
    private let columns = [GridItem(.adaptive(minimum: 140, maximum: 160))]
}

extension AllToolsView: View {
    var body: some View {
        ToyPage {
            LazyVGrid(columns: columns) {
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "Base 64 Encoder / Decoder".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        Base64CoderView(
                            state: self.state.base64CoderViewState
                        )
                    } label: {
                        Label {
                            Text("Base 64")
                            Text("Encode and decode Base64 data")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "b.square")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "Hash Generator".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        HashGeneratorView(
                            state: self.state.hashGeneratorViewState
                        )
                    } label: {
                        Label {
                            Text("Hash")
                            Text(
                                "Calculate MD5, SHA1, SHA256 and SHA512 hash from text data"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "number")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "HTML Encoder / Decoder".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        HTMLCoderView(state: self.state.htmlCoderViewState)
                    } label: {
                        Label {
                            Text("HTML")
                            Text(
                                "Encode or decode all the applicable characters to their corresponding HTML entities"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "chevron.left.slash.chevron.right")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "JSON Formatter".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        JSONFormatterView(
                            state: self.state.jsonFormatterViewState
                        )
                    } label: {
                        Label {
                            Text("JSON")
                            Text("Indenti or minify JSON data")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "curlybraces")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "JSON <> YAML Converter".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        JSONYAMLConverterView()
                    } label: {
                        Label {
                            Text("JSON <> YAML")
                            Text("Convert JSON data to YAML and vice versa")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "doc.plaintext")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "JWT Decoder".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        JWTDecoderView(
                            state: self.state.jwtDecoderViewState
                        )
                    } label: {
                        Label {
                            Text("JWT Decoder")
                            Text(
                                "Decode a JWT header, payload and signature"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "rays")
                                .font(.system(size: 50).bold())
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "Number Base Converter".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        NumberBaseConverterView(
                            state: self.state.numberBaseConverterViewState
                        )
                    } label: {
                        Label {
                            Text("Number Base")
                            Text("Convert numbers from one base to another")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "number.square")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "URL Encoder / Decoder".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        URLCoderView(
                            state: self.state.urlCoderViewState
                        )
                    } label: {
                        Label {
                            Text("URL")
                            Text("Encode or decode all the applicable characters to their corresponding URL entities")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "link")
                        }
                    }
                    .hoverEffect()
                }
                if !self.isSearching
                    || self.searchQuery.isEmpty
                    || "UUID Generator".lowercased()
                        .contains(self.searchQuery.lowercased())
                {
                    NavigationLink {
                        UUIDGeneratorView(
                            state: self.state.uuidGeneratorViewState
                        )
                    } label: {
                        Label {
                            Text("UUID")
                            Text("Generate UUIDs version 1 and 4")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "01.square")
                        }
                    }
                    .hoverEffect()
                }
            }
            .labelStyle(AllToolsLabelStyle())
            .foregroundStyle(.primary)
        }
        .navigationTitle(
            !self.isSearching || self.searchQuery.isEmpty
                ? "All tools"
                : "Search results"
        )
    }
}

struct AllToolsView_Previews: PreviewProvider {
    static var previews: some View {
        AllToolsView(searchQuery: "")
            .environmentObject(AppState())
    }
}
