//
//  EditNoteUIView.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

protocol EditNoteUIViewDelegate: AnyObject {
    func editTapped(note: String, priority: Int)
}

class EditNoteUIView: UIView {
    
    private let editLabel = UILabel()
    private let textField = UITextField()
    private let priorityLabel = UILabel()
    private let prioritySegmentControl = UISegmentedControl(
        items: [
            R.string.localizable.low(),
            R.string.localizable.normal(),
            R.string.localizable.high()]
    )
    private let editTaskBtn = UIButton()
    
    weak var delegate: EditNoteUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        initTextField()
        initProiorityLabel()
        initPrioritySegmentControl()
        initEditTaskBtn()
    }
    
    private func initEditLabel() {
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        editLabel.text = R.string.localizable.editNote()
        editLabel.font = .systemFont(ofSize: 26, weight: .bold)
        
        addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
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
            editTaskBtn.backgroundColor = .green
        case 1:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            editTaskBtn.backgroundColor = .orange
        case 2:
            prioritySegmentControl.selectedSegmentTintColor = .red
            editTaskBtn.backgroundColor = .red
        default:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            editTaskBtn.backgroundColor = .orange
        }
    }
    
    private func initEditTaskBtn() {
        editTaskBtn.translatesAutoresizingMaskIntoConstraints = false
        editTaskBtn.translatesAutoresizingMaskIntoConstraints = false
        editTaskBtn.setTitle(R.string.localizable.addNewNote(), for: .normal)
        editTaskBtn.setTitleColor(.black, for: .normal)
        editTaskBtn.backgroundColor = .orange
        editTaskBtn.layer.cornerRadius = 10
        editTaskBtn.addTarget(self, action: #selector(editNoteTapped), for: .touchUpInside)
        
        addSubview(editTaskBtn)
        editTaskBtn.snp.makeConstraints { make in
            make.top.equalTo(prioritySegmentControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
    }
    
    @objc private func editNoteTapped() {
        delegate?.editTapped(note: textField.text ?? "", priority: prioritySegmentControl.selectedSegmentIndex)
    }
    
    private func setupColor(priority: Int) {
        switch priority {
        case 0:
            prioritySegmentControl.selectedSegmentTintColor = .green
            editTaskBtn.backgroundColor = .green
        case 1:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            editTaskBtn.backgroundColor = .orange
        case 2:
            prioritySegmentControl.selectedSegmentTintColor = .red
            editTaskBtn.backgroundColor = .red
        default:
            prioritySegmentControl.selectedSegmentTintColor = .orange
            editTaskBtn.backgroundColor = .orange
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupData(note: String, priority: Int) {
        textField.text = note
        prioritySegmentControl.selectedSegmentIndex = priority
        setupColor(priority: priority)
        
    }

}
