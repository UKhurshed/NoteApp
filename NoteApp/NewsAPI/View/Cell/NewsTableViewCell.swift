//
//  NewsTableViewCell.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let image = UIImageView()
    private let newsTitle = UILabel()
    private let newsDescription = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initImage()
        initTitle()
        initDescription()
    }
    
    private func initImage() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(80)
            make.width.equalTo(90)
        }
    }
    
    private func initTitle() {
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.font = .systemFont(ofSize: 17, weight: .bold)
        
        contentView.addSubview(newsTitle)
        newsTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(image.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func initDescription() {
        newsDescription.translatesAutoresizingMaskIntoConstraints = false
        newsDescription.font = .systemFont(ofSize: 14, weight: .regular)
        newsDescription.numberOfLines = 0
        
        contentView.addSubview(newsDescription)
        newsDescription.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp.bottom).offset(5)
            make.leading.equalTo(image.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(viewData: ViewData) {
        image.sd_setImage(with: URL(string: viewData.urlToImage ?? ""))
        newsTitle.text = viewData.title
        newsDescription.text = viewData.description
    }
    
}
