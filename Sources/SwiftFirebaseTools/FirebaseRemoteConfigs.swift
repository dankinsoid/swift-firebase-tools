import Firebase
import FirebaseRemoteConfigInternal
import FirebaseRemoteConfig
import Foundation
@_exported import SwiftConfigs

public struct FirebaseRemoteConfigsHandler: ConfigsHandler {

    private let config: RemoteConfig
		private let source: RemoteConfigSource

	public init(config: RemoteConfig = .remoteConfig(), source: RemoteConfigSource = .remote) {
        self.config = config
				self.source = source
    }

    public func fetch(completion: @escaping (Error?) -> Void) {
        config.fetchAndActivate { _, error in
            completion(error)
        }
    }

    public func listen(_ listener: @escaping () -> Void) -> ConfigsCancellation? {
        let cancellable = config.addOnConfigUpdateListener { _, error in
            if error == nil {
                listener()
            }
        }
        return ConfigsCancellation {
            cancellable.remove()
        }
    }

    public func value(for key: String) -> String? {
        config.configValue(forKey: key, source: source).stringValue
    }
}
