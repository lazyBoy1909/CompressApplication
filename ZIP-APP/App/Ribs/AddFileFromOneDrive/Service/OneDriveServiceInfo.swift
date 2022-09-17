//
//  OneDriveServiceInfo.swift
//  Zip
//
//

import Foundation

private struct Const {
    static let kAccountIdentifier = "kAccountIdentifier"
    static let kAccessToken = "kOneDriveAccessToken"
}

class OneDriveServiceInfo {
    static var current = OneDriveServiceInfo()

    private var isItemIdDownloading: [String: Bool] = [:]
    private var names: [String: String] = [
        "Unknown": "One Drive"
    ]

    var accountIdentifier: String? {
        get {
            UserDefaults.standard.string(forKey: Const.kAccountIdentifier)
        }

        set {
            UserDefaults.standard.set(newValue, forKey: Const.kAccountIdentifier)
        }
    }

    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: Const.kAccessToken)
        }

        set {
            UserDefaults.standard.set(newValue, forKey: Const.kAccessToken)
        }
    }

    // MARK: - Method
    func logout() {
        self.accessToken = nil
        self.accountIdentifier = nil
    }

    func markDownloading(itemId: String) {
        isItemIdDownloading[itemId] = true
    }

    func unmarkDownloading(itemId: String) {
        isItemIdDownloading.removeValue(forKey: itemId)
    }

    func isDownloading(itemId: String) -> Bool {
        return isItemIdDownloading[itemId] ?? false
    }

    func name(id: String) -> String? {
        return names[id]
    }

    func saveName(item: CloudItem) {
        self.names[item.identifier()] = item.name()
    }
}
