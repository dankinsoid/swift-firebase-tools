import Firebase
import FirebaseRemoteConfigInternal
import FirebaseRemoteConfig
import Foundation
@_exported import SwiftConfigs

public typealias FirebaseRemoteConfigsHandler = FirebaseRemoteConfigStore

public struct FirebaseRemoteConfigStore: ConfigStore {

	public let isWritable = false
	private let config: RemoteConfig
	private let source: RemoteConfigSource
	private let _keys: Set<String>?
	private let allKeysKey: String?
	private let allKeysDecoding: (String) throws -> [String]
	
	public init(
		config: RemoteConfig = .remoteConfig(),
		source: RemoteConfigSource = .remote,
		allKeys: Set<String>?
	) {
		self.config = config
		self.source = source
		self._keys = allKeys
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
		self._keys = nil
		self.allKeysKey = allKeysKey
		self.allKeysDecoding = allKeysDecoding
	}
	
	public func fetch(completion: @escaping (Error?) -> Void) {
		config.fetchAndActivate { _, error in
			completion(error)
		}
	}

	public func onChange(_ listener: @escaping () -> Void) -> SwiftConfigs.Cancellation {
		let cancellable = config.addOnConfigUpdateListener { _, error in
			if error == nil {
				listener()
			}
		}
		return Cancellation {
			cancellable.remove()
		}
	}

	public func onChangeOfKey(_ key: String, _ listener: @escaping (String?) -> Void) -> SwiftConfigs.Cancellation {
		onChange {
			listener(self.get(key))
		}
	}
	
	public func get(_ key: String) -> String? {
		let value = config.configValue(forKey: key, source: source)
		return value.stringValue
	}

	public func keys() -> Set<String>? {
		if let _keys {
			return _keys
		}
		if let allKeysKey, let string = get(allKeysKey) {
			return try? Set(allKeysDecoding(string))
		}
		return nil
	}

	public func set(_ value: String?, for key: String) throws {
		throw UnsupportedOperationError()
	}

	public func removeAll() throws {
		throw UnsupportedOperationError()
	}
}

private struct ImpossibleError: Error {
}

struct UnsupportedOperationError: Error {
}
