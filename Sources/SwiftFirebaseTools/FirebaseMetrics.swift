#if canImport(FirebasePerformance)
import Foundation
import FirebasePerformance
import Metrics

//struct FirebaseMetricsFactory: MetricsFactory {
//
//    public func makeCounter(label: String, dimensions: [(String, String)]) -> CounterHandler {
//        FirebaseCounter(label: label)
//    }
//
//    public func makeRecorder(label: String, dimensions: [(String, String)], aggregate: Bool) -> RecorderHandler {
//        
//    }
//
//    public func makeTimer(label: String, dimensions: [(String, String)]) -> TimerHandler {
//        
//    }
//
//    public func destroyCounter(_ handler: any CounterHandler) {
//        
//    }
//
//    public func destroyRecorder(_ handler: any RecorderHandler) {
//        
//    }
//
//    public func destroyTimer(_ handler: any TimerHandler) {
//        
//    }
//}

private final class FirebaseCounter: CounterHandler {
    
    let label: String

    init(label: String) {
        self.label = label
    }

    func increment(by value: Int64) {
        guard let trace = Performance.startTrace(name: "metrics") else { return }
        trace.incrementMetric(label, by: value)
        trace.stop()
    }

    func reset() {
        guard let trace = Performance.startTrace(name: "metrics") else { return }
        trace.setValue(0, forMetric: label)
        trace.stop()
    }
}
#endif
