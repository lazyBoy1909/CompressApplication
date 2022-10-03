//
//  ODItemEntity.swift
//  Zip
//
//  Created by Linh Nguyen Duc on 08/07/2022.
//

import Foundation

struct ODItemEntity {
    var id: String
    var name: String
    var size: UInt64
    var isFolder: Bool
    var createdDateTime: Date
    var lastModifiedDateTime: Date
    var downloadURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case size = "size"
        case folder = "folder"
        case createdDateTime = "createdDateTime"
        case downloadURL = "@microsoft.graph.downloadUrl"
        case lastModifiedDateTime = "lastModifiedDateTime"
    }
}

extension ODItemEntity: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.size = try values.decode(UInt64.self, forKey: .size)
        self.isFolder = values.contains(.folder)
        self.downloadURL = try? values.decode(URL.self, forKey: .downloadURL)

        let formatter = ISO8601DateFormatter()
        self.createdDateTime = (formatter.date(from: try values.decode(String.self, forKey: .createdDateTime))) ?? Date()
        self.lastModifiedDateTime = (formatter.date(from: try values.decode(String.self, forKey: .lastModifiedDateTime))) ?? Date()
    }
}
