struct NumberBaseConverter {
    var isFormatOn = true

    func convert(
        _ value: Int128,
        to type: NumberType,
        uppercase: Bool = true
    ) -> String {
        guard value != 0 else {
            guard type == .binary else {
                return "0"
            }
            return "0000"
        }

        var converted: String
        if type != .decimal && value < 0 {
            // 2's complement
            converted = .init(
                UInt128(bitPattern: value),
                radix: type.radix,
                uppercase: uppercase
            )
        } else {
            converted = .init(
                value,
                radix: type.radix,
                uppercase: uppercase
            )
        }

        if type == .binary {
            // Zero Padding
            converted =
                String(
                    repeating: "0",
                    count: value.leadingZeroBitCount % 4
                ) + converted
        }

        return self.isFormatOn
            ? Self.format(converted, type: type)
            : converted
    }

    private static func format(
        _ value: String,
        type: NumberType
    ) -> String {
        value
            .reversed()
            .enumerated()
            .reduce(into: "") { acc, cur in
                let (i, c) = cur
                if i > 0 && c != "-"
                    && i.isMultiple(of: type.digitsInGroup)
                {
                    acc = String(c) + type.separator + acc
                } else {
                    acc = String(c) + acc
                }
            }
    }
}

#if TESTING_ENABLED
    import Foundation
    import PlaygroundTester

    @objcMembers
    final class NumberBaseConverterTests: TestCase {
        func testConvertToHexadecimal() {
            var converter = NumberBaseConverter()
            AssertEqual(
                "75C 710D",
                other: converter.convert(123_498_765, to: .hexadecimal)
            )
            AssertEqual(
                "FFFF FFFF FFFF FFFF",
                other: converter.convert(-1, to: .hexadecimal)
            )
            converter.isFormatOn = false
            AssertEqual(
                "75C710D",
                other: converter.convert(123_498_765, to: .hexadecimal)
            )
        }

        func testConvertToDecimal() {
            var converter = NumberBaseConverter()
            AssertEqual(
                "123,498,765",
                other: converter.convert(123_498_765, to: .decimal)
            )
            AssertEqual(
                "-1",
                other: converter.convert(-1, to: .decimal)
            )
            converter.isFormatOn = false
            AssertEqual(
                "123498765",
                other: converter.convert(123_498_765, to: .decimal)
            )
        }

        func testConvertToOctal() {
            var converter = NumberBaseConverter()
            AssertEqual(
                "727 070 415",
                other: converter.convert(123_498_765, to: .octal)
            )
            AssertEqual(
                "1 777 777 777 777 777 777 777",
                other: converter.convert(-1, to: .octal)
            )
            converter.isFormatOn = false
            AssertEqual(
                "727070415",
                other: converter.convert(123_498_765, to: .octal)
            )
        }

        func testConvertToBinary() {
            var converter = NumberBaseConverter()
            AssertEqual(
                "0111 0101 1100 0111 0001 0000 1101",
                other: converter.convert(123_498_765, to: .binary)
            )
            AssertEqual(
                "1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111",
                other: converter.convert(-1, to: .binary)
            )
            AssertEqual(
                "0000",
                other: converter.convert(0, to: .binary)
            )
            converter.isFormatOn = false
            AssertEqual(
                "0111010111000111000100001101",
                other: converter.convert(123_498_765, to: .binary)
            )
        }
    }
#endif
