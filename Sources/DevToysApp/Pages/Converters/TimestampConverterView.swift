import SwiftUI

struct TimestampConverterView {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @FocusState private var focusedField: Bool
    @ObservedObject private var state: TimestampConverterViewState

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
                        .foregroundColor(.yellow)
                    Text("Invalid value")
                    Spacer()
                }
                .padding()
                .background(.yellow.opacity(0.2))
                .cornerRadius(8)
            }
            self.timestampSection
            self.utcSection
            self.localTimeZoneSection
        }
        .navigationTitle(Tool.timestampConverter.strings.localizedLongTitle)
    }

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
                .font(.body.monospacedDigit())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                Stepper("", value: .constant(0))
                    .labelsHidden()
                Button("Now", action: self.state.setNow)
                    .buttonStyle(.bordered)
                    .hoverEffect()
            }
        }
    }

    private var utcSection: some View {
        ToySection(
            self.hSizeClass == .compact ? "UTC" : "UTC Date and Time"
        ) {
            DatePicker("", selection: self.$state.date, displayedComponents: [.date, .hourAndMinute])
                .environment(\.timeZone, .init(identifier: "UTC")!)
                .labelsHidden()
        } content: {
            HStack {
                self.component("Year", value: self.state.utcYear)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Month", value: self.state.utcMonth)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Day", value: self.state.utcDay)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .lineLimit(1)
            .font(.body.monospacedDigit())
            HStack {
                self.component("Hour (24H)", value: self.state.utcHour)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Minutes", value: self.state.utcMinutes)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Seconds", value: self.state.utcSeconds)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .lineLimit(1)
            .font(.body.monospacedDigit())
        }
    }

    private var localTimeZoneSection: some View {
        ToySection(
            self.hSizeClass == .compact ? "Local" : "Local Date and Time"
        ) {
            DatePicker("", selection: self.$state.date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
        } content: {
            HStack {
                self.component("Year", value: self.state.localYear)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Month", value: self.state.localMonth)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Day", value: self.state.localDay)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .lineLimit(1)
            .font(.body.monospacedDigit())
            HStack {
                self.component("Hour (24H)", value: self.state.localHour)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Minutes", value: self.state.localMinutes)
                    .frame(maxWidth: .infinity, alignment: .leading)
                self.component("Seconds", value: self.state.localSeconds)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .lineLimit(1)
            .font(.body.monospacedDigit())
        }
    }

    private func component(_ title: LocalizedStringKey, value: Binding<Int>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            if self.hSizeClass == .compact {
                VStack {
                    TextField(
                        "",
                        value: value,
                        format: .number.grouping(.never)
                    )
                    .textFieldStyle(.roundedBorder)
                    Stepper("", value: value)
                        .labelsHidden()
                }
            } else {
                HStack {
                    TextField(
                        "",
                        value: value,
                        format: .number.grouping(.never)
                    )
                    .textFieldStyle(.roundedBorder)
                    Stepper("", value: value)
                        .labelsHidden()
                }
            }
        }
    }
}

struct TimestampConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimestampConverterView(state: .init())
        }
        .navigationViewStyle(.stack)
        .previewPresets()
    }
}
