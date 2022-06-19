//
//  ViewController.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

class HomeViewController: UIViewController, HomeDelegate {
   
    
    private let myHomeView = HomeView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        myHomeView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNote()
    }
    
    private func fetchNote() {
        do {
            let result = try context.fetch(Note.fetchRequest())
            myHomeView.myNotes = result
            if myHomeView.tableView != nil {
                myHomeView.tableView.reloadData()
            }
        } catch {
            print("Failed fetch note \(error)")
        }
    }
    
    func onSelectRow(note: Note?) {
        let detailViewController = DetailViewController()
        detailViewController.modalPresentationStyle = .fullScreen
        if note != nil {
            detailViewController.note = note
        }
        present(detailViewController, animated: true)
    }
    
    func onDeleteRow(note: Note, index: Int) {
        context.delete(note)
        do {
            try context.save()
        } catch {
            print("Failed save data \(error)")
        }
        myHomeView.myNotes.remove(at: index)
    }
    
    private func setupView() {
        let navigationbar = getNavigationbar()
        view.addSubview(navigationbar)
        view.addSubview(myHomeView)
        NSLayoutConstraint.activate([
            navigationbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            myHomeView.topAnchor.constraint(equalTo: navigationbar.bottomAnchor, constant: 0),
            myHomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            myHomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            myHomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension HomeViewController {
    func getNavigationbar() -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        navbar.translatesAutoresizingMaskIntoConstraints = false
        UINavigationBar.appearance().barTintColor = .white
        let navItem = UINavigationItem()
        let rightBar = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd))
        navItem.rightBarButtonItem = rightBar
        navItem.title = "Notes ku nichh"
        navbar.setItems([navItem], animated: true)
        
        return navbar
    }
    
    @objc func onAdd() {
        onSelectRow(note: nil)
    }
}
