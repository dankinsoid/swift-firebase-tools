import Foundation
@_exported import SwiftAnalytics
import FirebaseAnalytics

public struct FirebaseAnalyticsHandler: AnalyticsHandler {

    public var parameters: [String: String] = [:]

    public init() {
    }

    public func send(event: SwiftAnalytics.Analytics.Event, fileID: String, function: String, line: UInt) {
        FirebaseAnalytics.Analytics.logEvent(event.name, parameters: parameters.merging(event.parameters) { _, new in new })
    }
}
