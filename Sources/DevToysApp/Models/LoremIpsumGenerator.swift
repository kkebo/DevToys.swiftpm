import LoremSwiftum

struct LoremIpsumGenerator {
    static let loremIpsumPrefix = "Lorem ipsum dolor sit amet"
    var type = LoremIpsumType.paragraphs
    var length = 1
    var startWithLoremIpsum = false

    func generate() -> String {
        var output: String
        switch self.type {
        case .words:
            output = Lorem.words(self.length)
            output = output.prefix(1).uppercased() + output.dropFirst()
        case .sentences: output = Lorem.sentences(self.length)
        case .paragraphs: output = Lorem.paragraphs(self.length)
        }

        if self.startWithLoremIpsum {
            let loremIpsumTokens = Self.loremIpsumPrefix
                .split(separator: " ")
            var tokens = output.split(separator: " ")
            let k = min(loremIpsumTokens.count, tokens.count)
            tokens[0..<k] = loremIpsumTokens[0..<k]
            output = tokens.joined(separator: " ")
        }

        return output
    }
}

#if TESTING_ENABLED
import PlaygroundTester

@objcMembers
final class LoremIpsumGeneratorTests: TestCase {
    func testGenerateWords() {
        var generator = LoremIpsumGenerator()
        generator.type = .words
        generator.length = 3
        let out = generator.generate()
        AssertEqual(3, other: out.split(separator: " ").count)
        Assert(out.first?.isUppercase == true)

        generator.length = 5
        generator.startWithLoremIpsum = true
        AssertEqual(
            LoremIpsumGenerator.loremIpsumPrefix,
            other: generator.generate()
        )
    }

    func testGenerateSentences() {
        var generator = LoremIpsumGenerator()
        generator.type = .sentences
        generator.length = 3
        AssertEqual(
            3,
            other: generator.generate().split(separator: ".").count
        )

        generator.startWithLoremIpsum = true
        AssertEqual(
            LoremIpsumGenerator.loremIpsumPrefix,
            other: String(
                generator.generate()
                    .prefix(LoremIpsumGenerator.loremIpsumPrefix.count)
            )
        )
    }

    func testGenerateParagraphs() {
        var generator = LoremIpsumGenerator()
        generator.length = 3
        AssertEqual(
            3,
            other: generator.generate().split(separator: "\n").count
        )

        generator.startWithLoremIpsum = true
        AssertEqual(
            LoremIpsumGenerator.loremIpsumPrefix,
            other: String(
                generator.generate()
                    .prefix(LoremIpsumGenerator.loremIpsumPrefix.count)
            )
        )
    }
}
#endif
