import SwiftUI

extension View {
    private static var dynamicTypeSizes: [DynamicTypeSize] {
        [
            .xSmall,
            .medium,
            .xxxLarge,
        ]
    }

    func previewPresets() -> some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) { scheme in
                self.preferredColorScheme(scheme)
                    .previewDisplayName("\(scheme)")
            }

            ForEach(Self.dynamicTypeSizes, id: \.self) { size in
                self.environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
        }
    }
}
