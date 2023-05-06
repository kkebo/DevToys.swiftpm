import Combine
import SwiftUI

import struct Foundation.Calendar
import struct Foundation.Date

@MainActor
final class TimestampConverterViewState {
    private static let utcCalendar: Calendar = {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .gmt
        return calendar
    }()

    @Published var timestampString = "" {
        didSet { self.updateTimestamp() }
    }
    @Published private(set) var timestamp: Int?

    var date: Binding<Date> {
        .init(
            get: {
                self.timestamp.map(Double.init).map { Date(timeIntervalSince1970: $0) } ?? .now
            },
            set: {
                self.timestampString = .init(Int($0.timeIntervalSince1970))
            }
        )
    }

    init() {
        let date = Date.now
        let timestamp = Int(date.timeIntervalSince1970)
        self.timestampString = .init(timestamp)
        self.timestamp = timestamp
    }

    func setNow() {
        self.timestampString = .init(Int(Date.now.timeIntervalSince1970))
    }

    private func updateTimestamp() {
        self.timestamp = Int(self.timestampString)
    }
}

extension TimestampConverterViewState: ObservableObject {}
