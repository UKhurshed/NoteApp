//
//  NewsViewModel.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import Foundation


protocol NewsViewModel {
    var eventHandler: ((_ event: NewsViewState) -> Void)? { get set }
    func getNews(query: String)
}

class NewsViewModelImpl: NewsViewModel {
    
    private let service: NewsService
    
    var eventHandler: ((_ event: NewsViewState) -> Void)?
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getNews(query: String) {
        Task {
            do {
                eventHandler?(.loading)
                let viewData = try await service.getNewsByQuery(query: query)
                eventHandler?(.success(viewData: viewData))
            } catch let error {
                eventHandler?(.failure(errorMessage: error.localizedDescription))
            }
        }
    }
    
}


enum NewsViewState {
    case loading
    case success(viewData: [ViewData])
    case failure(errorMessage: String)
}
