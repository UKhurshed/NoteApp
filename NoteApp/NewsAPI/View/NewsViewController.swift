//
//  NewsViewController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var newsUIView: NewsUIView {
        self.view as! NewsUIView
    }
    
    override func loadView() {
        view = NewsUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        observeEvent()
        
        newsUIView.delegate = self
        
//        viewModel.getNews(query: "tesla")
    }
    
    private func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.newsUIView.showLoader()
                }
            case .success(let viewData):
                DispatchQueue.main.async {
                    print("viewData: \(viewData)")
                    self.newsUIView.hideLoader()
                    self.newsUIView.setupData(viewData: viewData)
                }
            case .failure(let errorMessage):
                DispatchQueue.main.async {
                    self.newsUIView.errorOccurred()
                    self.presentAlertError(message: errorMessage)
                }
            }
        }
    }
    
    func presentAlertError(message: String) {
        print("error message: \(message)")
        DispatchQueue.main.async {
            let alert  = UIAlertController(title: R.string.localizable.titleErrorLabel(), message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension NewsViewController: NewsUIViewDelegate {
    func searchEnding(text: String) {
        viewModel.getNews(query: text)
    }

}
