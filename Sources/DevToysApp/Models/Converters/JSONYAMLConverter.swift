import Foundation
import UniYAML

struct JSONYAMLConverter {
    static func convert(
        _ input: String,
        mode: JSONYAMLConversionMode
    ) throws -> String {
        let inputObject = try UniYAML.decode(input)
        switch mode {
        case .yamlToJSON:
            let output = try UniYAML.encode(inputObject, with: .json)
            let json = try JSONSerialization.jsonObject(with: Data(output.utf8))
            return String(
                data: try JSONSerialization.data(
                    withJSONObject: json,
                    options: [.prettyPrinted, .sortedKeys]
                ),
                encoding: .utf8
            ) ?? ""
        case .jsonToYAML:
            return try UniYAML.encode(inputObject, with: .yaml)
        }
    }
}

#if TESTING_ENABLED
    import Foundation
    import PlaygroundTester

    @objcMembers
    final class JSONYAMLConverterTests: TestCase {
        func testYAMLCommentsToJSON() throws {
            let yaml = #"""
                # A single line comment example

                # block level comment example
                # comment line 1
                # comment line 2
                # comment line 3
                """#
            AssertEqual(
                "",
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLIntegerToJSON() throws {
            let yaml = "n1: 1"
            let json = #"""
                {
                  "n1" : 1
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLFloatToJSON() throws {
            let yaml = "n2: 1.234"
            let json = #"""
                {
                  "n2" : 1.234
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLStringToJSON() throws {
            let yaml = #"""
                s1: 'abc'
                s2: "abc"
                s3: abc
                """#
            let json = #"""
                {
                  "s1" : "abc",
                  "s2" : "abc",
                  "s3" : "abc"
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLMultilineStringsToJSON() throws {
            let yaml = #"""
                description: |
                  hello
                  world
                """#
            let json = #"""
                {
                  "description" : "hello\nworld\n"
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLFoldedStringsToJSON() throws {
            let yaml = #"""
                description: >
                  hello
                  world
                """#
            let json = #"""
                {
                  "description" : "hello world\n"
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLBooleanToJSON() throws {
            let yaml = "b: false"
            let json = #"""
                {
                  "b" : false
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLDateToJSON() throws {
            let yaml = "d: 2015-04-05"
            let json = #"""
                {
                  "d" : "2015-04-05"
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLInheritanceToJSON() throws {
            let yaml = #"""
                parent: &defaults
                  a: 2
                  b: 3

                child:
                  <<: *defaults
                  b: 4
                """#
            let json = #"""
                {
                  "child" : {
                    "a" : 2,
                    "b" : 4
                  },
                  "parent" : {
                    "a" : 2,
                    "b" : 3
                  }
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLVariablesToJSON() throws {
            let yaml = #"""
                some_thing: &VAR_NAME foobar
                other_thing: *VAR_NAME
                """#
            let json = #"""
                {
                  "other_thing" : "foobar",
                  "some_thing" : "foobar"
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLReferenceToJSON() throws {
            let yaml = #"""
                values: &ref
                  - Will be
                  - reused below
                  
                other_values:
                  i_am_ref: *ref
                """#
            let json = #"""
                {
                  "other_values" : {
                    "i_am_ref" : [
                      "Will be",
                      "reused below"
                    ]
                  },
                  "values" : [
                    "Will be",
                    "reused below"
                  ]
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLSequenceToJSON() throws {
            let yaml = #"""
                - Mark McGwire
                - Sammy Sosa
                - Ken Griffey
                """#
            let json = #"""
                [
                  "Mark McGwire",
                  "Sammy Sosa",
                  "Ken Griffey"
                ]
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLMappingToJSON() throws {
            let yaml = #"""
                hr:  65       # Home runs
                avg: 0.278    # Batting average
                rbi: 147      # Runs Batted In
                """#
            let json = #"""
                {
                  "avg" : 0.278,
                  "hr" : 65,
                  "rbi" : 147
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLMappingToSequencesToJSON() throws {
            let yaml = #"""
                attributes:
                  - a1
                  - a2
                methods: [getter, setter]
                """#
            let json = #"""
                {
                  "attributes" : [
                    "a1",
                    "a2"
                  ],
                  "methods" : [
                    "getter",
                    "setter"
                  ]
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLSequenceOfMappingsToJSON() throws {
            let yaml = #"""
                children:
                  - name: Jimmy Smith
                    age: 15
                  - name: Jimmy Smith
                    age: 15
                  -
                    name: Sammy Sosa
                    age: 12
                """#
            let json = #"""
                {
                  "children" : [
                    {
                      "age" : 15,
                      "name" : "Jimmy Smith"
                    },
                    {
                      "age" : 15,
                      "name" : "Jimmy Smith"
                    },
                    {
                      "age" : 12,
                      "name" : "Sammy Sosa"
                    }
                  ]
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLSequenceOfSequencesToJSON() throws {
            let yaml = #"""
                my_sequences:
                  - [1, 2, 3]
                  - [4, 5, 6]
                  -  
                    - 7
                    - 8
                    - 9
                    - 0
                """#
            let json = #"""
                {
                  "my_sequences" : [
                    [
                      1,
                      2,
                      3
                    ],
                    [
                      4,
                      5,
                      6
                    ],
                    [
                      7,
                      8,
                      9,
                      0
                    ]
                  ]
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLMappingOfMappingsToJSON() throws {
            let yaml = #"""
                Mark McGwire: {hr: 65, avg: 0.278}
                Sammy Sosa: {
                    hr: 63,
                    avg: 0.288
                  }
                """#
            let json = #"""
                {
                  "Mark McGwire" : {
                    "avg" : 0.278,
                    "hr" : 65
                  },
                  "Sammy Sosa" : {
                    "avg" : 0.288,
                    "hr" : 63
                  }
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLNestedCollectionsToJSON() throws {
            let yaml = #"""
                Jack:
                  id: 1
                  name: Franc
                  salary: 25000
                  hobby:
                    - a
                    - b
                  location: {country: "A", city: "A-A"}
                """#
            let json = #"""
                {
                  "Jack" : {
                    "hobby" : [
                      "a",
                      "b"
                    ],
                    "id" : 1,
                    "location" : {
                      "country" : "A",
                      "city" : "A-A"
                    },
                    "name" : "Franc",
                    "salary" : 25000
                  }
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLUnorderedSetsToJSON() throws {
            let yaml = #"""
                set1: !!set
                  ? one
                  ? two
                set2: !!set {'one', "two"}
                """#
            let json = #"""
                {
                  "set1" : {
                    "one" : null,
                    "two" : null
                  },
                  "set2" : {
                    "one" : null,
                    "two" : null
                  }
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testYAMLOrderedMappingsToJSON() throws {
            let yaml = #"""
                ordered: !!omap
                - Mark McGwire: 65
                - Sammy Sosa: 63
                - Ken Griffy: 58
                """#
            let json = #"""
                {
                  "ordered" : [
                    {
                      "Mark McGwire" : 65
                    },
                    {
                      "Sammy Sosa" : 63
                    },
                    {
                      "Ken Griffy" : 58
                    }
                  ]
                }
                """#
            AssertEqual(
                json,
                other: try JSONYAMLConverter.convert(yaml, mode: .yamlToJSON)
            )
        }

        func testJSONToYAML() throws {
            let json = "{ a: 3 }"
            let yaml = "a: 3\n"
            AssertEqual(
                yaml,
                other: try JSONYAMLConverter.convert(json, mode: .jsonToYAML)
            )
        }
    }
#endif
