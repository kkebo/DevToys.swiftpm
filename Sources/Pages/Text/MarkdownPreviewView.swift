import SwiftUI

struct MarkdownPreviewView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Bindable private var state: MarkdownPreviewViewState

    init(state: AppState) {
        self.state = state.markdownPreviewViewState
    }
}

extension MarkdownPreviewView: View {
    var body: some View {
        ToyPage {
            if self.hSizeClass == .compact {
                self.markdownSection
                self.previewSection
            } else {
                HStack {
                    self.markdownSection
                    Divider()
                    self.previewSection
                }
            }
        }
        .navigationTitle(Tool.markdownPreview.strings.localizedLongTitle)
    }

    @MainActor
    private var markdownSection: some View {
        ToySection("Markdown") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            CodeEditor(text: self.$state.input)
                .frame(idealHeight: 200)
        }
    }

    @MainActor
    private var previewSection: some View {
        ToySection("Preview") {
            CopyButton(text: self.state.output)
        } content: {
            HTMLView(self.state.output)
        }
    }
}

struct MarkdownPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MarkdownPreviewView(state: .init())
        }
        .previewPresets()
    }
}
