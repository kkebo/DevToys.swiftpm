import HTMLEntities

struct HTMLCoder {
    static func encode(_ input: String) -> String {
        input.htmlEscape(useNamedReferences: true)
    }

    static func decode(_ input: String) -> String {
        input.htmlUnescape()
    }
}
