import Foundation
import FirebaseRemoteConfigInternal
@_exported import SwiftRemoteConfigs
import Firebase

public struct FirebaseRemoteConfigsHandler: RemoteConfigsHandler {

    private let config: RemoteConfig

    public init(config: RemoteConfig = .remoteConfig()) {
        self.config = config
    }

    public func fetch(completion: @escaping (Error?) -> Void) {
        config.fetchAndActivate { _, error in
            completion(error)
        }
    }

    public func listen(_ listener: @escaping () -> Void) -> RemoteConfigsCancellation? {
        let cancellable = config.addOnConfigUpdateListener { _, error in
            if error == nil {
                listener()
            }
        }
        return RemoteConfigsCancellation {
            cancellable.remove()
        }
    }

    public func value(for key: String) -> String? {
        return config.configValue(forKey: key).stringValue
    }
}
