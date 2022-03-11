import SwiftJSONFormatter
import SwiftUI

private enum Indentation {
    case twoSpaces
    case fourSpaces
    case oneTab
    case minified
}

extension Indentation: CustomStringConvertible {
    var description: String {
        switch self {
        case .twoSpaces: return "2 spaces"
        case .fourSpaces: return "4 spaces"
        case .oneTab: return "1 tab"
        case .minified: return "Minified"
        }
    }
}

extension Indentation: Identifiable {
    var id: Self { self }
}

extension Indentation: CaseIterable {}

struct JSONFormatterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @State private var indentation = Indentation.twoSpaces
    @State private var input = ""
    @State private var isImporterPresented = false

    private var output: String {
        switch self.indentation {
        case .twoSpaces:
            return SwiftJSONFormatter.beautify(self.input, indent: "  ")
        case .fourSpaces:
            return SwiftJSONFormatter.beautify(self.input, indent: "    ")
        case .oneTab:
            return SwiftJSONFormatter.beautify(self.input, indent: "\t")
        case .minified:
            return SwiftJSONFormatter.minify(self.input)
        }
    }

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }

    private func openFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else {
            logger.error("Failed to start accessing security scoped resource.")
            return
        }
        defer { url.stopAccessingSecurityScopedResource() }
        do {
            self.input = try .init(contentsOf: url)
        } catch {
            logger.error("\(error.localizedDescription)")
            return
        }
    }
}

extension JSONFormatterView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Indentation", systemImage: "increase.indent") {
                    Picker("", selection: self.$indentation) {
                        ForEach(Indentation.allCases) {
                            Text(LocalizedStringKey($0.description))
                        }
                    }
                }
            }

            if self.hSizeClass == .compact {
                self.inputSection
                self.outputSection
            } else {
                HStack {
                    self.inputSection
                    Divider()
                    self.outputSection
                }
            }
        }
        .navigationTitle("JSON Formatter")
    }

    private var inputSection: some View {
        ToySection("Input") {
            Button {
                self.input = UIPasteboard.general.string ?? ""
            } label: {
                Label("Paste", systemImage: "doc.on.clipboard")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
            Button {
                if self.isImporterPresented {
                    // Workaround for the known issue
                    // https://developer.apple.com/forums/thread/693140
                    self.isImporterPresented = false
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + .milliseconds(50)
                    ) {
                        self.isImporterPresented = true
                    }
                } else {
                    self.isImporterPresented = true
                }
            } label: {
                Image(systemName: "doc")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
            .fileImporter(
                isPresented: self.$isImporterPresented,
                allowedContentTypes: [.data]
            ) {
                switch $0 {
                case .success(let url):
                    self.openFile(url)
                case .failure(let error):
                    logger.error("\(error.localizedDescription)")
                }
            }
            Button(role: .destructive) {
                self.input.removeAll()
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
            .disabled(self.input.isEmpty)
        } content: {
            TextEditor(text: self.$input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            Button {
                UIPasteboard.general.string = self.output
            } label: {
                Label("Copy", systemImage: "doc.on.doc")
            }
            .buttonStyle(.bordered)
            .hoverEffect()
        } content: {
            TextEditor(text: .constant(self.output))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }
}

struct JSONFormatterView_Previews: PreviewProvider {
    static var previews: some View {
        JSONFormatterView()
    }
}
