//
//  AddNoteUIView.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import UIKit

protocol AddNoteUIViewDelegate: AnyObject {
    func addNote(note: String, priority: Int)
}

class AddNoteUIView: UIView {
    
    private let addLabel = UILabel()
    private let textField = UITextField()
    private let priorityLabel = UILabel()
    private let prioritySegmentControl = UISegmentedControl(
        items: [
            R.string.localizable.low(),
            R.string.localizable.normal(),
            R.string.localizable.high()]
    )
    private let addTaskBtn = UIButton()
    
    weak var delegate: AddNoteUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        initAddLabel()
        initTextField()
        initProiorityLabel()
        initPrioritySegmentControl()
        initAddTaskBtn()
    }
    
    private func initAddLabel() {
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        addLabel.text = R.string.localizable.addNote()
        addLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        addSubview(addLabel)
        addLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func initTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.placeholder = R.string.localizable.textFieldDescription()
        textField.becomeFirstResponder()
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.textField.frame.height))
        textField.leftView = padding
        textField.leftViewMode = .always
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(addLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
    }
    
    private func initProiorityLabel() {
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.text = R.string.localizable.priority()
        priorityLabel.textColor = .black
        priorityLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        
        addSubview(priorityLabel)
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    private func initPrioritySegmentControl() {
        prioritySegmentControl.translatesAutoresizingMaskIntoConstraints = false
        prioritySegmentControl.selectedSegmentIndex = 1
        prioritySegmentControl.selectedSegmentTintColor = .orange
        
        prioritySegmentControl.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        
        addSubview(prioritySegmentControl)
        prioritySegmentControl.snp.makeConstraints { make in
            make.top.equalTo(priorityLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func colorChanged() {
        switch prioritySegmentControl.selectedSegmentIndex {
        case 0:
            prioritySegmentControl.selectedSegmentTintColor = .green
            addTaskBtn.backgroundColor = .green
        case 1:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            addTaskBtn.backgroundColor = .orange
        case 2:
            prioritySegmentControl.selectedSegmentTintColor = .red
            addTaskBtn.backgroundColor = .red
        default:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            addTaskBtn.backgroundColor = .orange
        }
    }
    
    private func initAddTaskBtn() {
        addTaskBtn.translatesAutoresizingMaskIntoConstraints = false
        addTaskBtn.translatesAutoresizingMaskIntoConstraints = false
        addTaskBtn.setTitle(R.string.localizable.addNewNote(), for: .normal)
        addTaskBtn.setTitleColor(.black, for: .normal)
        addTaskBtn.backgroundColor = .orange
        addTaskBtn.layer.cornerRadius = 10
        addTaskBtn.addTarget(self, action: #selector(addNoteTapped), for: .touchUpInside)
        
        addSubview(addTaskBtn)
        addTaskBtn.snp.makeConstraints { make in
            make.top.equalTo(prioritySegmentControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
    }
    
    @objc private func addNoteTapped() {
        delegate?.addNote(note: textField.text ?? "", priority: prioritySegmentControl.selectedSegmentIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
