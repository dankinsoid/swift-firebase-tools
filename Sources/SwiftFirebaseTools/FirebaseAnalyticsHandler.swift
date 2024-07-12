import Foundation
@_exported import SwiftAnalytics
import FirebaseAnalytics

public struct FirebaseAnalyticsHandler: AnalyticsHandler {

    public var parameters: SwiftAnalytics.Analytics.Parameters
    
    public init(parameters: SwiftAnalytics.Analytics.Parameters = [:]) {
        self.parameters = parameters
    }
    
    public func send(
        event: SwiftAnalytics.Analytics.Event,
        file: String,
        function: String,
        line: UInt,
        source: String
    ) {
        FirebaseAnalytics.Analytics.logEvent(
            event.name,
            parameters: event.parameters
                .merging(parameters) { o, _ in o }
                .mapValues(\.description)
        )
    }
}
