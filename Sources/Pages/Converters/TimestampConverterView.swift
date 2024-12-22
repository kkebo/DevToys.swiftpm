import SwiftUI

struct TimestampConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Bindable private var state: TimestampConverterViewState

    init(state: AppState) {
        self.state = state.timestampConverterViewState
    }
}

extension TimestampConverterView: View {
    var body: some View {
        ToyPage {
            if !self.state.timestampString.isEmpty
                && self.state.timestamp == nil
            {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                    Text("Invalid value")
                    Spacer()
                }
                .padding()
                .background(.yellow.opacity(0.2))
                .cornerRadius(8)
            }
            self.timestampSection
            DatePicker(
                self.hSizeClass == .compact ? "UTC" : "UTC Date and Time",
                selection: self.state.date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .environment(\.timeZone, .gmt)
            DatePicker(
                self.hSizeClass == .compact ? "Local" : "Local Date and Time",
                selection: self.state.date,
                displayedComponents: [.date, .hourAndMinute]
            )
        }
        .navigationTitle(Tool.timestampConverter.strings.localizedLongTitle)
    }

    @MainActor
    private var timestampSection: some View {
        ToySection("Timestamp") {
            PasteButton(text: self.$state.timestampString)
            CopyButton(text: self.state.timestampString)
        } content: {
            HStack {
                TextField(
                    "Unix Timestamp",
                    text: self.$state.timestampString
                )
                .modifier(ClearButtonModifier(text: self.$state.timestampString))
                .keyboardType(.numberPad)
                .monospacedDigit()
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                Stepper(
                    "",
                    value: .init(
                        get: { self.state.timestamp ?? 0 },
                        set: { self.state.timestampString = .init($0) }
                    )
                )
                .labelsHidden()
                .disabled(self.state.timestamp == nil)
                Button("Now") {
                    self.state.setNow()
                }
                .buttonStyle(.bordered)
                .hoverEffect()
            }
        }
    }
}

struct TimestampConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TimestampConverterView(state: .init())
        }
        .previewPresets()
    }
}
