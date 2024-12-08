import Observation

@Observable
final class ListComparerViewState {
    var comparisonMode = ListComparisonMode.intersection {
        didSet { self.didUpdate() }
    }
    var isCaseSensitive = false {
        didSet { self.didUpdate() }
    }
    var a = "" {
        didSet { self.didUpdate() }
    }
    var b = "" {
        didSet { self.didUpdate() }
    }
    private(set) var output = ""

    private func didUpdate() {
        self.output = ListComparer.compare(
            a: self.a,
            b: self.b,
            caseSensitive: self.isCaseSensitive,
            mode: self.comparisonMode
        )
    }
}
