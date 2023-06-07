//
//  CustomError.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation

enum CustomError: Error {
    case jsonParseError
    case urlRequestNull
    case nullData
    case urlCallError
    case networkSessionError
    case freedReference
    case serviceWasNil
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .jsonParseError:
            return R.string.localizable.jsonParseError()
        case .urlRequestNull:
            return R.string.localizable.urlConvertIsNull()
        case .nullData:
            return R.string.localizable.dataFromDataTaskIsNull()
        case .urlCallError:
            return R.string.localizable.thereIsNoInternetConnection()
        case .networkSessionError:
            return R.string.localizable.networkSessionError()
        case .freedReference:
            return R.string.localizable.freedReference()
        case .serviceWasNil:
            return R.string.localizable.serviceWasNil()
        }
    }
}
