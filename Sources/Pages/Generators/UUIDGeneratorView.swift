import SwiftUI

struct UUIDGeneratorView {
    @Bindable private var state: UUIDGeneratorViewState
    @FocusState private var isFocused: Bool

    init(state: AppState) {
        self.state = state.uuidGeneratorViewState
    }
}

@MainActor
extension UUIDGeneratorView: View {
    var body: some View {
        ToyPage {
            self.configurationSection
            self.generateSection
            self.outputSection
        }
        .navigationTitle(Tool.uuidGenerator.strings.localizedLongTitle)
    }

    private var configurationSection: some View {
        ToySection("Configuration") {
            ConfigurationRow("Hyphens", systemImage: "minus") {
                Toggle("", isOn: self.$state.generator.usesHyphens)
                    .tint(.accentColor)
                    .labelsHidden()
            }
            ConfigurationRow("Uppercase", systemImage: "textformat") {
                Toggle("", isOn: self.$state.generator.isUppercase)
                    .tint(.accentColor)
                    .labelsHidden()
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
                .labelsHidden()
            }
        }
    }

    private var generateSection: some View {
        ToySection("Generate") {
            HStack {
                Button(
                    self.state.numberOfUUIDs > 1
                        ? "Generate UUIDs"
                        : "Generate UUID"
                ) {
                    self.state.generate()
                }
                .buttonStyle(.borderedProminent)
                .hoverEffect()
                Text("x")
                TextField("N", text: self.$state.numberOfUUIDsString)
                    .modifier(ClearButtonModifier(text: self.$state.numberOfUUIDsString))
                    .frame(maxWidth: 80)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                    .monospacedDigit()
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused(self.$isFocused)
                    .onChange(of: self.isFocused) { _, newValue in
                        if !newValue {
                            self.state.commitNumberOfUUIDs()
                        }
                    }
                Stepper("", value: self.$state.numberOfUUIDs, in: 1...10000)
                    .labelsHidden()
            }
        }
    }

    private var outputSection: some View {
        ToySection(
            self.state.numberOfUUIDs > 1 ? "UUIDs" : "UUID"
        ) {
            CopyButton(text: self.state.output)
            ClearButton(text: self.$state.output)
        } content: {
            CodeEditor(text: .constant(self.state.output))
                .frame(idealHeight: 200)
        }
    }
}

struct UUIDGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UUIDGeneratorView(state: .init())
        }
        .previewPresets()
    }
}
