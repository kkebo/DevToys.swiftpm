import SwiftUI

struct MarkdownPreviewView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @ObservedObject private var state: MarkdownPreviewViewState

    init(state: MarkdownPreviewViewState) {
        self.state = state

        Task { @MainActor in
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

extension MarkdownPreviewView: View {
    var body: some View {
        ToyPage {
            if self.hSizeClass == .compact {
                self.inputSection
                self.outputSection
            } else {
                HStack {
                    self.inputSection
                    Divider()
                    self.outputSection
                }
            }
        }
        .navigationTitle("Markdown Preview")
    }

    private var inputSection: some View {
        ToySection("Input") {
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
        }
    }

    private var outputSection: some View {
        ToySection("Output") {
            CopyButton(text: self.state.output)
        } content: {
            HTMLView(self.state.output)
        }
    }
}

struct MarkdownPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownPreviewView(state: .init())
            .previewPresets()
    }
}
