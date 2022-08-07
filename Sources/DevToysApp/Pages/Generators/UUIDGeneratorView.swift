import SwiftUI

struct UUIDGeneratorView {
    @ObservedObject var state: UUIDGeneratorViewState
    @FocusState private var isFocused: Bool

    init(state: AppState) {
        self.state = state.uuidGeneratorViewState
    }
}

extension UUIDGeneratorView: View {
    var body: some View {
        ToyPage {
            self.configurationSection
            self.generateSection
            self.outputSection
        }
        .navigationTitle(Tool.uuidGenerator.strings.localizedLongTitle)
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
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
                        : "Generate UUID",
                    action: self.state.generate
                )
                .buttonStyle(.borderedProminent)
                .hoverEffect()
                Text("x")
                TextField("N", text: self.$state.numberOfUUIDsString)
                    .modifier(ClearButtonModifier(text: self.$state.numberOfUUIDsString))
                    .frame(maxWidth: 80)
                    .fixedSize(horizontal: true, vertical: false)
                    .keyboardType(.numberPad)
                    .font(.body.monospacedDigit())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused(self.$isFocused)
                    .onChange(of: self.isFocused) { isFocused in
                        if !isFocused {
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
        NavigationView {
            UUIDGeneratorView(state: .init())
        }
        .navigationViewStyle(.stack)
        .previewPresets()
    }
}
