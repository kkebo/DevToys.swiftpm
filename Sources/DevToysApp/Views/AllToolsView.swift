import SwiftUI

private struct AllToolsLabelStyle {}

extension AllToolsLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 50))
                .frame(width: 80, height: 80)
                .background(
                    .quaternary,
                    in: RoundedRectangle(cornerRadius: 8)
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
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
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
                        Base64EncoderDecoderView(
                            viewModel: self.state.base64EncoderDecoderViewModel
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
                            viewModel: self.state.hashGeneratorViewModel
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
                        HTMLEncoderDecoderView(
                            viewModel: self.state.htmlEncoderDecoderViewModel
                        )
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
                            viewModel: self.state.jsonFormatterViewModel
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
                            viewModel: self.state.jwtDecoderViewModel
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
                            viewModel: self.state.numberBaseConverterViewModel
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
                        URLEncoderDecoderView(
                            viewModel: self.state.urlEncoderDecoderViewModel
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
                            viewModel: self.state.uuidGeneratorViewModel
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
