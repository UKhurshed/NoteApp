//
//  TabBarController.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noteVC = HomeScreenViewController()
        let newsVC = NewsAssembly.configureModule()
        
        noteVC.navigationItem.backButtonTitle = ""
        newsVC.navigationItem.backButtonTitle = ""
        
        noteVC.title = R.string.localizable.projectName()
        newsVC.title = R.string.localizable.newsFeed()
        
        noteVC.navigationItem.largeTitleDisplayMode = .always
        newsVC.navigationItem.largeTitleDisplayMode = .always
        
        let navNote = UINavigationController(rootViewController: noteVC)
        let navNews = UINavigationController(rootViewController: newsVC)
        
        navNote.tabBarItem = UITabBarItem(title: "Notes", image: UIImage(systemName: "note.text"), tag: 1)
        navNews.tabBarItem = UITabBarItem(title: "News API", image: UIImage(systemName: "network"), tag: 1)
        
        navNote.navigationBar.prefersLargeTitles = true
        navNews.navigationBar.prefersLargeTitles = true
    
        setViewControllers([navNote, navNews], animated: false)
    }
    
}
