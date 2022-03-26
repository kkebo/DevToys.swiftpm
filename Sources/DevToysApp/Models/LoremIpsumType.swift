enum LoremIpsumType: String {
    case words
    case sentences
    case paragraphs
}

extension LoremIpsumType: Identifiable {
    var id: Self { self }
}

extension LoremIpsumType: CaseIterable {}
