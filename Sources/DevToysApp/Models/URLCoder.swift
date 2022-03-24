struct URLCoder {
    static func encode(_ input: String) -> String? {
        input.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
                .subtracting(
                    .init(charactersIn: ":#[]@!$&'()*+,;=")
                )
        )
    }

    static func decode(_ input: String) -> String? {
        input.removingPercentEncoding
    }
}
