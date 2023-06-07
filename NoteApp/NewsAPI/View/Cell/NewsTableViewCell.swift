//
//  NewsTableViewCell.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NoteTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
