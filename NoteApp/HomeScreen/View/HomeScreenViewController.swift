//
//  HomeScreenViewController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 06.06.2023.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    let homeViewModel = HomeViewModel()
    
    private var homeScreenUIView: HomeScreenUIView {
        self.view as! HomeScreenUIView
    }
    
    override func loadView() {
        view = HomeScreenUIView()
    }
    
    let dataManager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.projectName()
        configureNavBar()
        
        configuration()
    
    }
    
    private func configuration() {
        observeEvent()
        homeViewModel.getAllNotes()
    }
    
    private func observeEvent() {
        homeViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            print("event: \(event)")
            switch event {
            case .success(let notes):
                DispatchQueue.main.async {
                    self.homeScreenUIView.setupData(notes: notes)
                }
                break
            case .error(let errorMessage):
                presentAlertError(message: errorMessage)
            }
        }
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addNote))
    }
    
    @objc private func addNote() {
        let addNoteVC = AddNoteViewController {
            self.homeViewModel.getAllNotes()
        }
        present(addNoteVC, animated: true)
    }

    func presentAlertError(message: String) {
        print("error message: \(message)")
        DispatchQueue.main.async {
            let alert  = UIAlertController(title: R.string.localizable.titleErrorLabel(), message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: R.string.localizable.tryAgain(), style: .default, handler: { [weak self] action in
                self?.homeViewModel.getAllNotes()
            }))
            self.present(alert, animated: true)
        }
    }
}
