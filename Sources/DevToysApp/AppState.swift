import Combine

@MainActor
final class AppState {
    let numberBaseConverterViewState = NumberBaseConverterViewState()
    let base64CoderViewState = Base64CoderViewState()
    let htmlCoderViewState = HTMLCoderViewState()
    let jwtDecoderViewState = JWTDecoderViewState()
    let urlCoderViewState = URLCoderViewState()
    let jsonFormatterViewState = JSONFormatterViewState()
    let hashGeneratorViewState = HashGeneratorViewState()
    let uuidGeneratorViewState = UUIDGeneratorViewState()
    let loremIpsumGeneratorViewState = LoremIpsumGeneratorViewState()
    let markdownPreviewViewState = MarkdownPreviewViewState()
    let timestampConverterViewState = TimestampConverterViewState()
}

extension AppState: ObservableObject {}
