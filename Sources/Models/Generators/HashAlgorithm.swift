enum HashAlgorithm: String {
    case md5
    case sha1
    case sha256
    case sha384
    case sha512
}

extension HashAlgorithm: Identifiable {
    var id: Self { self }
}

extension HashAlgorithm: CaseIterable {}
