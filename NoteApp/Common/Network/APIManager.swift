//
//  APIManager.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation
import Alamofire

struct APIConstants {
    static let baseURL: String = "https://newsapi.org/v2/"
}


struct APIManager {
    
    private let path: String
    private let method: HTTPMethod
    private let params: Parameters?
    
    init(path: String, method: HTTPMethod = .get, params: Parameters? = nil) {
        self.path = path
        self.method = method
        self.params = params
    }
    
    public func callAPI() async throws -> Data {
        
        guard let url = URLComponents(string: "\(APIConstants.baseURL)\(path)") else {
            throw CustomError.urlRequestNull
        }
        
        var headers = HTTPHeaders()
        headers["content-type"] = "application/json"
        
        var innerParams = params
        innerParams?["apiKey"] = "fc9c93a0395d4d82ac5d3c736f184179"
        
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(url, method: method, parameters: innerParams, headers: headers).responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        })
    }
    
    private func handleError(error: AFError) -> Error {
            if let underlyingError = error.underlyingError {
                let nserror = underlyingError as NSError
                let code = nserror.code
                if code == NSURLErrorNotConnectedToInternet ||
                    code == NSURLErrorTimedOut ||
                    code == NSURLErrorInternationalRoamingOff ||
                    code == NSURLErrorDataNotAllowed ||
                    code == NSURLErrorCannotFindHost ||
                    code == NSURLErrorCannotConnectToHost ||
                    code == NSURLErrorNetworkConnectionLost
                {
                    var userInfo = nserror.userInfo
                    userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                    let currentError = NSError(
                        domain: nserror.domain,
                        code: code,
                        userInfo: userInfo
                    )
                    return currentError
                }
            }
            return error
        }
    
}
