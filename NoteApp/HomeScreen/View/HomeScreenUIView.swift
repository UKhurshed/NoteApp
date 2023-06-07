//
//  HomeScreenUIView.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import UIKit
import SnapKit

protocol HomeScreenUIViewDelegate: AnyObject {
    func noteItemTapped(note: NoteEntity)
    func deleteNote(note: NoteEntity)
}

class HomeScreenUIView: UIView {
    
    private let noteTableView = UITableView()
    private let noDataImage = UIImageView()
    
    var result = [NoteEntity]()
    
    weak var delegate: HomeScreenUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        initTableView()
        initNoDataImage()
    }
    
    private func initTableView() {
        noteTableView.translatesAutoresizingMaskIntoConstraints = false
        noteTableView.dataSource = self
        noteTableView.delegate = self
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        
        addSubview(noteTableView)
        noteTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(notes: [NoteEntity]) {
        if notes.isEmpty {
            noDataImage.isHidden = false
            noteTableView.isHidden = true
        } else {
            self.result = notes
            noDataImage.isHidden = true
            noteTableView.isHidden = false
            noteTableView.reloadData()
        }
    }
}

extension HomeScreenUIView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as! NoteTableViewCell
        cell.setupData(noteEntity: result[indexPath.row])
        return cell
    }
}

extension HomeScreenUIView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.noteItemTapped(note: self.result[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: R.string.localizable.delete()) { _, _, _ in
            self.delegate?.deleteNote(note: self.result[indexPath.row])
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
