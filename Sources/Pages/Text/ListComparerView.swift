import SwiftUI

struct ListComparerView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Bindable var state: ListComparerViewState

    init(state: AppState) {
        self.state = state.listComparerViewState
    }
}

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

            if self.hSizeClass == .compact {
                self.sectionA
                self.sectionB
            } else {
                HStack {
                    self.sectionA
                    Divider()
                    self.sectionB
                }
            }

            ToySection("AB") {
                CodeEditor(text: .constant(self.state.output))
            }
        }
        .navigationTitle(Tool.listComparer.strings.localizedLongTitle)
    }

    private var sectionA: some View {
        ToySection("A") {
            CodeEditor(text: self.$state.a)
        }
    }

    private var sectionB: some View {
        ToySection("B") {
            CodeEditor(text: self.$state.b)
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
