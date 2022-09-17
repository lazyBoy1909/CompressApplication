//
//  AFResponse.swift
//  Zip
//
//  Created by Linh Nguyen Duc on 08/07/2022.
//

import Foundation
import Alamofire

struct AFResponse<T> {
    var dataResponse: AFDataResponse<T>?
    var downloadResponse: AFDownloadResponse<T>?

    init(dataResponse: AFDataResponse<T>) {
        self.dataResponse = dataResponse
        self.downloadResponse = nil
    }

    init(downloadResponse: AFDownloadResponse<T>) {
        self.downloadResponse = downloadResponse
        self.dataResponse = nil
    }

    var response: HTTPURLResponse? {
        return dataResponse?.response ?? downloadResponse?.response
    }

    var error: AFError? {
        return dataResponse?.error ?? downloadResponse?.error
    }
}
