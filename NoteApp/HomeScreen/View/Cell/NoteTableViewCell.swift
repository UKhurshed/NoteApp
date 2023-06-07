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
    private let priorityIndicator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initNote()
        initPriorityIndicator()
    }
    
    private func initNote() {
        note.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(note)
        note.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func initPriorityIndicator() {
        priorityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(priorityIndicator)
        priorityIndicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
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
