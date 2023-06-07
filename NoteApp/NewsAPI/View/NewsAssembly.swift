//
//  NewsAssembly.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

class NewsAssembly {
    static func configureModule() -> UIViewController {
        
        let service = NewsServiceImpl()
        let viewModel = NewsViewModelImpl(service: service)
        let view = NewsViewController(viewModel: viewModel)
        
        return view
    }
}

