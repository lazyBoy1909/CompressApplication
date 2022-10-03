//
//  CommonResponse.swift
//  CoreNetworking
//
//  Created by Thanh Vu on 18/10/2021.
//

import Foundation

public enum ErrorCodeType: String, Error, Codable {
    case success = "SUCCESS"
    case notFound = "NOT_FOUND"
    case pageNotFound = "PAGE_NOT_FOUND"
    case internalServerError = "INTERNAL_SERVER_ERROR"
    case validationError = "VALIDATION_ERROR"
    case unauthorized = "UNAUTHORIZED"
    case passwordWrong = "PASSWORD_WRONG"
    case emailNotExist = "EMAIL_NOT_EXIST"
    case emailExist = "EMAIL_ALREADY_EXISTS"
    case itemDuplicate = "ITEM_DUPLICATE"
    case tokenExpired = "TOKEN_EXPIRED"
    case coinNotEnough = "COIN_NOT_ENOUGH"
    case alreadyCheckedIn = "ALREADY_CHECKED_IN"
    case verifyTokenNotFoundBill = "VERIFY_TOKEN_NOT_FOUND_BILL"
    case projectNotFound = "PROJECT_NOT_FOUND"
}

open class CommonResponse<Body: Codable>: Codable {
    open var errorCode: ErrorCodeType
    open var message: String?
    open var data: Body
}
