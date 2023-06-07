//
//  NewsUIView.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit
import JGProgressHUD

protocol NewsUIViewDelegate: AnyObject {
    func searchEnding(text: String)
}

class NewsUIView: UIView {
    
    private let searchBar = UISearchBar()
    private let newsTableView = UITableView()
    private let noDataImage = UIImageView()
    private let spinner = JGProgressHUD(style: .dark)
    
    private var result = [ViewData]()
    
    weak var delegate: NewsUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        initSearchBar()
        initTableView()
        initNoDataImage()
    }
    
    private func initSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func initTableView() {
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.separatorStyle = .none
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func initNoDataImage() {
        noDataImage.translatesAutoresizingMaskIntoConstraints = false
        noDataImage.isHidden = true
        noDataImage.contentMode = .scaleAspectFit
        noDataImage.image = R.image.noData()
        
        addSubview(noDataImage)
        noDataImage.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showLoader() {
        spinner.show(in: self)
    }
    
    public func hideLoader() {
        spinner.dismiss(animated: true)
    }
    
    public func errorOccurred() {
        spinner.dismiss(animated: true)
        self.newsTableView.isHidden = true
    }
    
    public func setupData(viewData: [ViewData]) {
        if viewData.isEmpty {
            noDataImage.isHidden = false
            newsTableView.isHidden = true
        } else {
            self.result = viewData
            noDataImage.isHidden = true
            newsTableView.isHidden = false
            newsTableView.reloadData()
        }
    }
}

extension NewsUIView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchEnding(text: searchBar.text ?? "")
    }
}

extension NewsUIView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.textLabel?.text = self.result[indexPath.row].title
        return cell
    }

    
}

extension NewsUIView: UITableViewDelegate {
    
}
