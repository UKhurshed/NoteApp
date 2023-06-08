//
//  NoteTableViewCell.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import UIKit

class NoteTableViewCell: UITableViewCell {


    static let identifier = "NoteTableViewCell"
    
    private let note = UILabel()
    private let indicatorBackView = UIView()
    private let priorityIndicator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initNote()
        initIndicatorBackView()
        initPriorityIndicator()
    }
    
    private func initNote() {
        note.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(note)
        note.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
    }
    
    private func initIndicatorBackView() {
        indicatorBackView.translatesAutoresizingMaskIntoConstraints = false
        indicatorBackView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(indicatorTapped)))
        
        contentView.addSubview(indicatorBackView)
        indicatorBackView.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc func indicatorTapped() {
        print("indicatorTapped")
    }
    
    private func initPriorityIndicator() {
        priorityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorBackView.addSubview(priorityIndicator)
        priorityIndicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(10)
        }
        
        priorityIndicator.layer.cornerRadius = 0.5 * 10
    }
    
    private func getPriorityColor(priority: Int) -> UIColor {
        switch priority {
        case 0:
            return .green
        case 1:
            return .orange
        case 2:
            return .red
        default:
            return .orange
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(noteEntity: NoteEntity) {
        note.text = noteEntity.note
        priorityIndicator.backgroundColor = getPriorityColor(priority: Int(noteEntity.priority))
        
    }
}
