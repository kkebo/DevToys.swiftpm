import SwiftUI

private enum UUIDVersion {
    case v1
    case v4
}

extension UUIDVersion: CustomStringConvertible {
    var description: String {
        switch self {
        case .v1: return "1"
        case .v4: return "4 (GUID)"
        }
    }
}

extension UUIDVersion: Identifiable {
    var id: Self { self }
}

extension UUIDVersion: CaseIterable {}

struct UUIDGeneratorView {
    @State private var usesHyphens = true
    @State private var isUppercase = false
    @State private var version = UUIDVersion.v4
    @State private var numberOfUUIDsString = "5"
    @State private var output = ""

    private var numberOfUUIDs: UInt? { .init(self.numberOfUUIDsString) }

    init() {
        Task.detached { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }

    private func generate() -> String {
        switch self.version {
        case .v1: preconditionFailure("not implemented")
        case .v4: return self.generateUUIDv4()
        }
    }

    private func generateUUIDv4() -> String {
        guard let numberOfUUIDs = self.numberOfUUIDs else { return "" }
        var uuids = (0..<numberOfUUIDs).lazy
            .map { _ in UUID().uuidString }
            .joined(separator: "\n")
        if !self.isUppercase {
            uuids = uuids.lowercased()
        }
        if !self.usesHyphens {
            uuids = uuids.split(separator: "-").joined()
        }
        return uuids
    }
}

extension UUIDGeneratorView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Hyphens", systemImage: "minus") {
                    Toggle("", isOn: self.$usesHyphens)
                        .tint(.accentColor)
                }
                ConfigurationRow("Uppercase", systemImage: "textformat") {
                    Toggle("", isOn: self.$isUppercase)
                        .tint(.accentColor)
                }
                ConfigurationRow(systemImage: "slider.horizontal.3") {
                    Text("UUID version")
                    Text("Choose the version of UUID to generate")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } content: {
                    Picker("", selection: self.$version) {
                        ForEach(UUIDVersion.allCases) {
                            Text($0.description)
                        }
                    }
                    .disabled(true)  // TODO: Uncomment if v1 is implemented
                }
            }

            ToySection("Generate") {
                HStack {
                    Button(
                        self.numberOfUUIDs ?? 0 > 1
                            ? "Generate UUIDs"
                            : "Generate UUID"
                    ) {
                        if self.output.isEmpty {
                            self.output = self.generate()
                        } else {
                            self.output += "\n" + self.generate()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .hoverEffect()
                    .disabled(self.numberOfUUIDs == nil)
                    Text("x")
                    TextField("N", text: self.$numberOfUUIDsString)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 80)
                        .keyboardType(.numberPad)
                        .font(.body.monospacedDigit())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .border(self.numberOfUUIDs == nil ? .red : .clear)
                }
            }

            ToySection(self.numberOfUUIDs ?? 0 > 1 ? "UUIDs" : "UUID") {
                Button {
                    UIPasteboard.general.string = self.output
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
                Button(role: .destructive) {
                    self.output.removeAll()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                .hoverEffect()
                .disabled(self.output.isEmpty)
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
        .navigationTitle("UUID Generator")
        .onAppear {
            self.output = self.generate()
        }
    }
}

struct UUIDGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        UUIDGeneratorView()
    }
}
