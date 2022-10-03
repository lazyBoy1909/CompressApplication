//
//  OneDriveItem.swift
//  Zip
//
//

import UIKit

struct ODItem {
    var id: String
    var name: String
    var size: UInt64
    var downloadURL: URL?
    var createdTime: Date
    var lastModifiedTime: Date
    var isFolder: Bool

    init(entity: ODItemEntity) {
        self.id = entity.id
        self.name = entity.name
        self.size = entity.size
        self.downloadURL = entity.downloadURL
        self.createdTime = entity.createdDateTime
        self.lastModifiedTime = entity.lastModifiedDateTime
        self.isFolder = entity.isFolder
    }
}

struct OneDriveItem {
    var item: ODItem?

    func downloadURL() -> URL? {
        return self.item?.downloadURL
    }
}

extension OneDriveItem: CloudItem {
    func identifier() -> String {
        if let id = self.item?.id {
            return "items/\(id)"
        }

        return "root"
    }

    func name() -> String {
        return self.item?.name ?? "One drive"
    }

    func size() -> UInt64 {
        return UInt64(self.item?.size ?? 0)
    }

    func thumbnail() -> UIImage {
        return FileType.thumbnail(pathExt: self.fileExtension() ?? "unknown")
    }

    func fileExtension() -> String? {
        if let lastDotIndex = self.name().lastIndex(of: Character(".")) {
            var pathExt = "\(self.name().suffix(from: lastDotIndex))"
            pathExt.removeFirst()
            return pathExt
        }

        return nil
    }

    func isDownloading() -> Bool {
        return OneDriveServiceInfo.current.isDownloading(itemId: self.identifier())
    }

    func isFolder() -> Bool {
        return self.item?.isFolder == true
    }
}
