//
//  NewsViewController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit
import SafariServices

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
                }
                self.presentAlertError(
                    title: R.string.localizable.titleErrorLabel(),
                    message: errorMessage,
                    actionStr: R.string.localizable.alertDismiss())
                
            }
        }
    }
}

extension NewsViewController: NewsUIViewDelegate {
    func searchEnding(text: String) {
        if text.isEmpty {
            self.presentAlertError(
                title: R.string.localizable.warningTitle(),
                message: R.string.localizable.wrongURL(),
                actionStr: R.string.localizable.ok())
        }
        viewModel.getNews(query: text)
    }
    
    func newsItemTapped(news: ViewData) {
        guard let url = URL(string: news.url ?? "") else {
            self.presentAlertError(
                title: R.string.localizable.warningTitle(),
                message: R.string.localizable.wrongURL(),
                actionStr: R.string.localizable.alertDismiss())
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}
