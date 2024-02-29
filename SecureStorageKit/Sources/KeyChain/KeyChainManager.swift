//
//  KeyChainManager.swift
//  SecureStorageKit
//
//  Created by 김동겸 on 2/29/24.
//

import Foundation
import Security

public enum KeyChainKey: String {
	case accessToken = "accessToken"
}

public final class KeyChainManager {
	private static let serviceName: String = "GuestHouse"
	
	///  KeyChain 값 생성
	@discardableResult
	public static func create(
		key: KeyChainKey,
		value: String
	) -> Bool {
		/*
		 kSecClass: 키체인 아이템 클래스 타입
		 kSecAttrAccount: 저장할 아이템의 계정 이름
		 kSecAttrService: 서비스 아이디 // 앱 번들 아이디
		 kSecValueData: 저장할 아이템의 데이터
		 */
		let keychainItem: [String: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key.rawValue,
			kSecAttrService: serviceName,
			kSecValueData: value.data(using: .utf8) as Any
		] as [String: Any]
		
		SecItemDelete(keychainItem as CFDictionary)
		
		let status: OSStatus = SecItemAdd(keychainItem as CFDictionary, nil)
		guard status == errSecSuccess else {
			print("Keychain create Error")
			return false
		}
		
		return true
	}
	
	///  KeyChain 값 불러오기
	public static func read(
		key: KeyChainKey
	) -> String? {
		let keychainItem: [String: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrAccount: key.rawValue,
			kSecAttrService: serviceName,
			kSecReturnData: true
		] as [String: Any]
		
		var item: AnyObject?
		let status: OSStatus = SecItemCopyMatching(keychainItem as CFDictionary, &item)
		if status == errSecSuccess {
			return String(data: item as? Data ?? Data(), encoding: .utf8)
		}
		
		if status == errSecItemNotFound {
			print("The \(key.rawValue) value was not found in keychain")
			return nil
		} else {
			print("Error getting \(key.rawValue) value from keychain: \(status)")
			return nil
		}
	}
	
	///  KeyChain 값 업데이트
	@discardableResult
	public static func update(
		key: KeyChainKey,
		value: String
	) -> Bool{
		let keychainItem: [String: Any] = [
			kSecClass: kSecClassGenericPassword
		] as [String: Any]
		
		let attributes: [CFString: Any] = [
			kSecAttrService: serviceName,
			kSecAttrAccount: key.rawValue,
			kSecValueData: value.data(using: .utf8) as Any
		]
		
		let status: OSStatus = SecItemUpdate(keychainItem as CFDictionary, attributes as CFDictionary)
		guard status != errSecItemNotFound else {
			print("The \(key.rawValue) value was not found in keychain")
			return false
		}
		
		guard status == errSecSuccess else {
			print("Keychain update Error")
			return false
		}
		
		print("The \(key.rawValue) value in keychain is updated")
		return true
	}
	
	///  KeyChain 값 삭제
	@discardableResult
	public static func delete(
		key: KeyChainKey
	) -> Bool{
		let keychainItem: [String: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrService: serviceName,
			kSecAttrAccount: key.rawValue
		] as [String: Any]
		
		let status: OSStatus = SecItemDelete(keychainItem as CFDictionary)
		guard status != errSecItemNotFound else {
			print("The \(key.rawValue) value was not found in keychain")
			return false
		}
		guard status == errSecSuccess else {
			print("Keychain delete Error")
			return false
		}
		
		print("The \(key.rawValue) value in keychain is deleted")
		return true
	}
}
