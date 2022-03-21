import Combine

final class AppState {
    let numberBaseConverterViewModel = NumberBaseConverterViewModel()
    let base64EncoderDecoderViewModel = Base64EncoderDecoderViewModel()
    let htmlEncoderDecoderViewModel = HTMLEncoderDecoderViewModel()
    let jwtDecoderViewModel = JWTDecoderViewModel()
    let urlEncoderDecoderViewModel = URLEncoderDecoderViewModel()
    let jsonFormatterViewModel = JSONFormatterViewModel()
    let hashGeneratorViewModel = HashGeneratorViewModel()
    let uuidGeneratorViewModel = UUIDGeneratorViewModel()
}

extension AppState: ObservableObject {}
