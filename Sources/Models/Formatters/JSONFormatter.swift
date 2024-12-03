import SwiftJSONFormatter

struct JSONFormatter {
    var indentation = JSONIndentation.twoSpaces

    func format(_ input: String) -> String {
        switch self.indentation {
        case .twoSpaces: SwiftJSONFormatter.beautify(input, indent: "  ")
        case .fourSpaces: SwiftJSONFormatter.beautify(input, indent: "    ")
        case .oneTab: SwiftJSONFormatter.beautify(input, indent: "\t")
        case .minified: SwiftJSONFormatter.minify(input)
        }
    }
}

#if TESTING_ENABLED
    import Foundation
    import PlaygroundTester

    @objcMembers
    final class JSONFormatterTests: TestCase {
        func testFormat() {
            let formatter = JSONFormatter()
            AssertEqual(
                """
                {
                  "menu": {
                    "id": "file",
                    "value": "File",
                    "popup": {
                      "menuitem": [
                        {
                          "value": "New",
                          "onclick": "CreateNewDoc()"
                        },
                        {
                          "value": "Open",
                          "onclick": "OpenDoc()"
                        },
                        {
                          "value": "Close",
                          "onclick": "CloseDoc()"
                        }
                      ]
                    }
                  }
                }
                """,
                other: formatter.format(
                    """
                    {"menu": {
                      "id": "file",
                      "value": "File",
                      "popup": {
                        "menuitem": [
                          {"value": "New", "onclick": "CreateNewDoc()"},
                          {"value": "Open", "onclick": "OpenDoc()"},
                          {"value": "Close", "onclick": "CloseDoc()"}
                        ]
                      }
                    }}
                    """
                )
            )
        }

        func testFormatMinified() {
            var formatter = JSONFormatter()
            formatter.indentation = .minified
            AssertEqual(
                #"{"menu":{"id":"file","value":"File","popup":{"menuitem":[{"value":"New","onclick":"CreateNewDoc()"},{"value":"Open","onclick":"OpenDoc()"},{"value":"Close","onclick":"CloseDoc()"}]}}}"#,
                other: formatter.format(
                    """
                    {"menu": {
                      "id": "file",
                      "value": "File",
                      "popup": {
                        "menuitem": [
                          {"value": "New", "onclick": "CreateNewDoc()"},
                          {"value": "Open", "onclick": "OpenDoc()"},
                          {"value": "Close", "onclick": "CloseDoc()"}
                        ]
                      }
                    }}
                    """
                )
            )
        }
    }
#endif
