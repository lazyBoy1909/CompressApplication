//
//  OneDriveFetchAPI.swift
//  Zip
//
//

import Foundation

class OneDriveFetchAPI: HttpEndpoint {
    var itemId: String

    init(itemId: String) {
        self.itemId = itemId
    }

    func baseURL() -> String {
        return "https://graph.microsoft.com/v1.0/me/drive"
    }

    func path() -> String {
        return "\(itemId)/children"
    }

    func headers() -> [String : String]? {
        return [
            "Authorization": "Bearer \(OneDriveServiceInfo.current.accessToken ?? "")"
        ]
    }

    func convertObject(data: Data) throws -> [OneDriveItem] {
        let response = try JSONDecoder().decode(OneDriveFetchEntity.self, from: data)
        return response.value.map({ OneDriveItem(item: ODItem(entity: $0)) })
    }
}
