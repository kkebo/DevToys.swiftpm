enum HashOutputType: String {
    case hex
    case base64
}

extension HashOutputType: Identifiable {
    var id: Self { self }
}

extension HashOutputType: CaseIterable {}
