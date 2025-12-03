import SwiftUI

struct ListComparerView {
    @Bindable var state: ListComparerViewState

    init(state: AppState) {
        self.state = state.listComparerViewState
    }
}

@MainActor
extension ListComparerView: View {
    var body: some View {
        ToyPage {
            ToySection("Configuration") {
                ConfigurationRow("Case sensitive comparison", systemImage: "textformat") {
                    Toggle("", isOn: self.$state.isCaseSensitive).labelsHidden()
                }
                ConfigurationRow("Comparison mode", systemImage: "brain") {
                    Picker("", selection: self.$state.comparisonMode) {
                        ForEach(ListComparisonMode.allCases, id: \.self) {
                            Text(LocalizedStringKey($0.description))
                        }
                    }
                    .labelsHidden()
                }
            }

            ResponsiveStack(spacing: 16) {
                self.sectionA
                self.sectionB
            }

            ToySection(LocalizedStringKey(self.state.comparisonMode.description)) {
                SaveFileButton(text: self.state.output)
                CopyButton(text: self.state.output)
            } content: {
                CodeEditor(text: .constant(self.state.output))
                    .frame(idealHeight: 200)
            }
        }
        .navigationTitle(Tool.listComparer.strings.localizedLongTitle)
    }

    private var sectionA: some View {
        ToySection("A") {
            PasteButton(text: self.$state.a)
            OpenFileButton(text: self.$state.a)
            ClearButton(text: self.$state.a)
        } content: {
            CodeEditor(text: self.$state.a)
                .frame(idealHeight: 100)
        }
    }

    private var sectionB: some View {
        ToySection("B") {
            PasteButton(text: self.$state.b)
            OpenFileButton(text: self.$state.b)
            ClearButton(text: self.$state.b)
        } content: {
            CodeEditor(text: self.$state.b)
                .frame(idealHeight: 100)
        }
    }
}

struct ListComparerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListComparerView(state: .init())
        }
        .previewPresets()
    }
}
