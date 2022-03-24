struct NumberBaseConverter {
    var isFormatOn = true

    func convert(
        _ value: Int,
        to type: NumberType,
        uppercase: Bool = true
    ) -> String {
        let converted: String
        if type != .decimal && value < 0 {
            // 2's complement
            converted = .init(
                UInt(bitPattern: value),
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
