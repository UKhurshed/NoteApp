//
//  NewsService.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation
import SwiftyJSON

protocol NewsService {
    func getNewsByQuery(query: String) async throws -> [ViewData]
}

class NewsServiceImpl: NewsService {
    func getNewsByQuery(query: String) async throws -> [ViewData] {
        let api = APIManager(path: "everything", method: .get, params: ["q" : query])
         
        let data: Data = try await api.callAPI()
        
        let viewData = try mappingData(data: data)
        
        return viewData
    }
    
    private func mappingData(data: Data) throws -> [ViewData]{
        let data: JSON = JSON(parseJSON: String(data: data, encoding: .utf8) ?? "")
        if data.isEmpty {
            throw NSError(domain: "UserServiceError", code: -2, userInfo: [NSLocalizedDescriptionKey: R.string.localizable.jsonParseError()])
        } else {
            var newsResult = [ViewData]()
            
            for item in data["articles"].arrayValue {
                let viewData = ViewData(
                    source: item["source"]["name"].string,
                    author: item["author"].string,
                    title: item["title"].string,
                    description: item["description"].string,
                    url: item["url"].string,
                    urlToImage: item["urlToImage"].string,
                    publishedAt: item["publishedAt"].string,
                    content: item["content"].string)
                
                newsResult.append(viewData)
            }
            
            return newsResult
        }
    }
}


struct ViewData {
    let source: String?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
