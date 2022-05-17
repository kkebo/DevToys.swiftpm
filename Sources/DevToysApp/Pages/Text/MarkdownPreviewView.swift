import Introspect
import SwiftUI

struct MarkdownPreviewView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ObservedObject var state: MarkdownPreviewViewState
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

    private var markdownSection: some View {
        ToySection("Markdown") {
            PasteButton(text: self.$state.input)
            OpenFileButton(text: self.$state.input)
            ClearButton(text: self.$state.input)
        } content: {
            TextEditor(text: self.$state.input)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.body.monospaced())
                .background(.regularMaterial)
                .cornerRadius(8)
                .frame(idealHeight: 200)
                .introspectTextView { textView in
                    textView.backgroundColor = .clear
                }
        }
    }

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
        NavigationView {
            MarkdownPreviewView(state: .init())
        }
        .previewPresets()
    }
}
