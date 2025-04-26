import SwiftUI

struct MarkdownPreviewView {
    @Bindable private var state: MarkdownPreviewViewState

    init(state: AppState) {
        self.state = state.markdownPreviewViewState
    }
}

@MainActor
extension MarkdownPreviewView: View {
    var body: some View {
        ToyPage {
            ResponsiveStack(spacing: 16) {
                self.markdownSection
                self.previewSection
            }
        }
        .navigationTitle(Tool.markdownPreview.strings.localizedLongTitle)
    }

    private var markdownSection: some View {
        ToySection("Markdown") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
            Divider().fixedSize()
            SaveFileButton(text: self.state.input)
            CopyButton(text: self.state.input)
        } content: {
            CodeEditor(text: self.$state.input)
                .frame(idealHeight: 200)
        }
    }

    private var previewSection: some View {
        ToySection("Preview") {
            SaveFileButton(text: self.state.output)
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
