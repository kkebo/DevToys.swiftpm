import Combine
import SwiftUI
import struct Foundation.Calendar
import struct Foundation.Date

final class TimestampConverterViewState {
    private static let utcCalendar: Calendar = {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .init(identifier: "UTC")!
        return calendar
    }()

    @Published var timestampString = "" {
        didSet { self.updateTimestamp() }
    }
    @Published var timestamp: Int? {
        didSet { self.updateDate() }
    }
    @Published var date: Date

    var utcDateComponents: DateComponents {
        Self.utcCalendar.dateComponents(
            [.calendar, .year, .month, .day, .hour, .minute, .second],
            from: self.date
        )
    }
    var localDateComponents: DateComponents {
        Calendar.autoupdatingCurrent.dateComponents(
            [.calendar, .year, .month, .day, .hour, .minute, .second],
            from: self.date
        )
    }

    var utcYear: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.year, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.year = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var utcMonth: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.month, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.month = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var utcDay: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.day, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.day = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var utcHour: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.hour, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.hour = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var utcMinutes: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.minute, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.minute = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var utcSeconds: Binding<Int> {
        .init(
            get: { Self.utcCalendar.component(.second, from: self.date) },
            set: { newValue in
                var components = self.utcDateComponents
                components.second = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }

    var localYear: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.year, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.year = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var localMonth: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.month, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.month = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var localDay: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.day, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.day = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var localHour: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.hour, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.hour = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var localMinutes: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.minute, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.minute = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }
    var localSeconds: Binding<Int> {
        .init(
            get: { Calendar.autoupdatingCurrent.component(.second, from: self.date) },
            set: { newValue in
                var components = self.localDateComponents
                components.second = newValue
                guard let date = components.date else { return }
                self.date = date
            }
        )
    }

    init() {
        let date = Date.now
        let timestamp = Int(date.timeIntervalSince1970)
        self.timestampString = .init(timestamp)
        self.timestamp = timestamp
        self.date = date
    }

    func setNow() {
        self.timestampString = .init(Int(Date.now.timeIntervalSince1970))
    }

    private func updateTimestamp() {
        self.timestamp = Int(self.timestampString)
    }

    private func updateDate() {
        if let timestamp = self.timestamp {
            self.date = Date(timeIntervalSince1970: .init(timestamp))
        }
    }
}

extension TimestampConverterViewState: ObservableObject {}
