import OrderedCollections

private struct CaseInsensitiveString<S: StringProtocol> {
    var value: S
}

extension CaseInsensitiveString: Hashable {}

extension CaseInsensitiveString: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value.caseInsensitiveCompare(rhs.value) == .orderedSame
    }
}

struct ListComparer {
    static func compare(a: String, b: String, caseSensitive: Bool, mode: ListComparisonMode) -> String {
        switch mode {
        case .intersection: Self.intersection(a: a, b: b, caseSensitive: caseSensitive)
        case .union: Self.union(a: a, b: b, caseSensitive: caseSensitive)
        case .aOnly: Self.difference(a: a, b: b, caseSensitive: caseSensitive)
        case .bOnly: Self.difference(a: b, b: a, caseSensitive: caseSensitive)
        }
    }

    private static func intersection(a: String, b: String, caseSensitive: Bool) -> String {
        if caseSensitive {
            OrderedSet(a.split(whereSeparator: \.isNewline))
                .intersection(b.split(whereSeparator: \.isNewline))
                .joined(separator: "\n")
        } else {
            OrderedSet(a.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .intersection(b.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .lazy
                .map(\.value)
                .joined(separator: "\n")
        }
    }

    private static func union(a: String, b: String, caseSensitive: Bool) -> String {
        if caseSensitive {
            OrderedSet(a.split(whereSeparator: \.isNewline))
                .union(b.split(whereSeparator: \.isNewline))
                .joined(separator: "\n")
        } else {
            OrderedSet(a.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .union(b.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .lazy
                .map(\.value)
                .joined(separator: "\n")
        }
    }

    private static func difference(a: String, b: String, caseSensitive: Bool) -> String {
        if caseSensitive {
            OrderedSet(a.split(whereSeparator: \.isNewline))
                .subtracting(b.split(whereSeparator: \.isNewline))
                .joined(separator: "\n")
        } else {
            OrderedSet(a.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .subtracting(b.split(whereSeparator: \.isNewline).map(CaseInsensitiveString.init))
                .lazy
                .map(\.value)
                .joined(separator: "\n")
        }
    }
}

#if TESTING_ENABLED
import Foundation
import PlaygroundTester

@objcMembers
final class ListComparerTests: TestCase {
    func testIntersectionCaseInsensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: false, mode: .intersection)
        }
        AssertEqual("", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("c", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("B", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("", other: compare(a: "", b: "d\nE\nf"))
    }

    func testIntersectionCaseSensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: true, mode: .intersection)
        }
        AssertEqual("", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("c", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("", other: compare(a: "", b: "d\nE\nf"))
    }

    func testUnionCaseInsensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: false, mode: .union)
        }
        AssertEqual("a\nB\nc\nd\nE\nf", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("a\nB\nc\nE\nf", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("a\nB\nc\nE\nf", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("a\nB\nc\nd\nE\nf", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("d\nE\nf", other: compare(a: "", b: "d\nE\nf"))
    }

    func testUnionCaseSensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: true, mode: .union)
        }
        AssertEqual("a\nB\nc\nd\nE\nf", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("a\nB\nc\nE\nf", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("a\nB\nc\nb\nE\nf", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("a\nB\nc\nb\nd\nE\nf", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("d\nE\nf", other: compare(a: "", b: "d\nE\nf"))
    }

    func testAOnlyCaseInsensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: false, mode: .aOnly)
        }
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("a\nB", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("a\nc", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("", other: compare(a: "", b: "d\nE\nf"))
    }

    func testAOnlyCaseSensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: true, mode: .aOnly)
        }
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("a\nB", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("a\nB\nc\nb", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("a\nB\nc", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("", other: compare(a: "", b: "d\nE\nf"))
    }

    func testBOnlyCaseInsensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: false, mode: .bOnly)
        }
        AssertEqual("d\nE\nf", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("E\nf", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("E\nf", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("d\nE\nf", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("d\nE\nf", other: compare(a: "", b: "d\nE\nf"))
    }

    func testBOnlyCaseSensitive() {
        func compare(a: String, b: String) -> String {
            ListComparer.compare(a: a, b: b, caseSensitive: true, mode: .bOnly)
        }
        AssertEqual("d\nE\nf", other: compare(a: "a\nB\nc", b: "d\nE\nf"))
        AssertEqual("E\nf", other: compare(a: "a\nB\nc", b: "c\nE\nf"))
        AssertEqual("b\nE\nf", other: compare(a: "a\nB\nc", b: "b\nE\nf"))
        AssertEqual("d\nE\nf", other: compare(a: "a\nB\nc\nb", b: "d\nE\nf"))
        AssertEqual("", other: compare(a: "a\nB\nc", b: ""))
        AssertEqual("d\nE\nf", other: compare(a: "", b: "d\nE\nf"))
    }
}
#endif

