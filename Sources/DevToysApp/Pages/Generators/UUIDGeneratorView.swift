import SwiftUI

struct UUIDGeneratorView {
    @ObservedObject private var state: UUIDGeneratorViewState

    init(state: UUIDGeneratorViewState) {
        self.state = state

        Task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension UUIDGeneratorView: View {
    var body: some View {
        ToyPage {
            self.configurationSection
            self.generateSection
            self.outputSection
        }
        .navigationTitle("UUID Generator")
    }

    private var configurationSection: some View {
        ToySection("Configuration") {
            ConfigurationRow("Hyphens", systemImage: "minus") {
                Toggle("", isOn: self.$state.generator.usesHyphens)
                    .tint(.accentColor)
                    .fixedSize(horizontal: true, vertical: false)
            }
            ConfigurationRow("Uppercase", systemImage: "textformat") {
                Toggle("", isOn: self.$state.generator.isUppercase)
                    .tint(.accentColor)
                    .fixedSize(horizontal: true, vertical: false)
            }
            ConfigurationRow(systemImage: "slider.horizontal.3") {
                Text("UUID version")
                Text("Choose the version of UUID to generate")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } content: {
                Picker("", selection: self.$state.generator.version) {
                    ForEach(UUIDVersion.allCases) {
                        Text($0.description)
                    }
                }
                .disabled(true)  // TODO: Uncomment if v1 is implemented
            }
        }
    }

    private var generateSection: some View {
        ToySection("Generate") {
            HStack {
                Button(
                    self.state.numberOfUUIDs ?? 0 > 1
                        ? "Generate UUIDs"
                        : "Generate UUID",
                    action: self.state.generate
                )
                .buttonStyle(.borderedProminent)
                .hoverEffect()
                .disabled(self.state.numberOfUUIDs == nil)
                Text("x")
                TextField("N", text: self.$state.numberOfUUIDsString)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 80)
                    .keyboardType(.numberPad)
                    .font(.body.monospacedDigit())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .border(self.state.numberOfUUIDs == nil ? .red : .clear)
            }
        }
    }

    private var outputSection: some View {
        ToySection(
            self.state.numberOfUUIDs ?? 0 > 1 ? "UUIDs" : "UUID"
        ) {
            CopyButton(text: self.state.output)
            ClearButton(text: self.$state.output)
        } content: {
            TextEditor(text: .constant(self.state.output))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
        }
    }
}

struct UUIDGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        UUIDGeneratorView(state: .init())
    }
}
