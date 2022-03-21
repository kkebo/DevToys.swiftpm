import SwiftUI

struct UUIDGeneratorView {
    @ObservedObject private var viewModel: UUIDGeneratorViewModel

    init(viewModel: UUIDGeneratorViewModel) {
        self.viewModel = viewModel

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
                Toggle("", isOn: self.$viewModel.usesHyphens)
                    .tint(.accentColor)
            }
            ConfigurationRow("Uppercase", systemImage: "textformat") {
                Toggle("", isOn: self.$viewModel.isUppercase)
                    .tint(.accentColor)
            }
            ConfigurationRow(systemImage: "slider.horizontal.3") {
                Text("UUID version")
                Text("Choose the version of UUID to generate")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } content: {
                Picker("", selection: self.$viewModel.version) {
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
                    self.viewModel.numberOfUUIDs ?? 0 > 1
                        ? "Generate UUIDs"
                        : "Generate UUID"
                ) {
                    if self.viewModel.output.isEmpty {
                        self.viewModel.output = self.viewModel.generate()
                    } else {
                        self.viewModel.output += "\n" + self.viewModel.generate()
                    }
                }
                .buttonStyle(.borderedProminent)
                .hoverEffect()
                .disabled(self.viewModel.numberOfUUIDs == nil)
                Text("x")
                TextField("N", text: self.$viewModel.numberOfUUIDsString)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 80)
                    .keyboardType(.numberPad)
                    .font(.body.monospacedDigit())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .border(
                        self.viewModel.numberOfUUIDs == nil ? .red : .clear
                    )
            }
        }
    }

    private var outputSection: some View {
        ToySection(
            self.viewModel.numberOfUUIDs ?? 0 > 1 ? "UUIDs" : "UUID"
        ) {
            CopyButton(text: self.viewModel.output)
            ClearButton(text: self.$viewModel.output)
        } content: {
            TextEditor(text: .constant(self.viewModel.output))
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
        UUIDGeneratorView(viewModel: .init())
    }
}
