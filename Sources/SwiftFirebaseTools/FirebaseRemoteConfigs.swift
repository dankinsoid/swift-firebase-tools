import Firebase
import FirebaseRemoteConfigInternal
import FirebaseRemoteConfig
import Foundation
@_exported import SwiftConfigs

public struct FirebaseRemoteConfigsHandler: ConfigsHandler {
	
	public let supportWriting = false
	private let config: RemoteConfig
	private let source: RemoteConfigSource
	private let keys: Set<String>?
	private let allKeysKey: String?
	private let allKeysDecoding: (String) throws -> [String]
	
	public init(
		config: RemoteConfig = .remoteConfig(),
		source: RemoteConfigSource = .remote,
		allKeys: Set<String>?
	) {
		self.config = config
		self.source = source
		self.keys = allKeys
		self.allKeysKey = nil
		self.allKeysDecoding = { _ in throw ImpossibleError() }
	}
	
	public init(
		config: RemoteConfig = .remoteConfig(),
		source: RemoteConfigSource = .remote,
		allKeysKey: String,
		allKeysDecoding: @escaping (String) throws -> [String] = { try JSONDecoder().decode([String].self, from: $0.data(using: .utf8) ?? Data()) }
	) {
		self.config = config
		self.source = source
		self.keys = nil
		self.allKeysKey = allKeysKey
		self.allKeysDecoding = allKeysDecoding
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
		let value = config.configValue(forKey: key, source: source)
		return value.stringValue
	}

	public func allKeys() -> Set<String>? {
		if let keys {
			return keys
		}
		if let allKeysKey, let string = value(for: allKeysKey) {
			return try? Set(allKeysDecoding(string))
		}
		return nil
	}
	
	public func writeValue(_ value: String?, for key: String) throws {
		throw UnsupportedOperationError()
	}
	
	public func clear() throws {
		throw UnsupportedOperationError()
	}
}

private struct ImpossibleError: Error {
}

struct UnsupportedOperationError: Error {
}
