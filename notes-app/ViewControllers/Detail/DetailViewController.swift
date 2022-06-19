//
//  DetailViewController.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

class DetailViewController: UIViewController {
    private let myDetailView = DetailView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var note: Note? {
        didSet {
            myDetailView.titleTextFieldView.text = note?.title
            myDetailView.contentTextFieldView.text = note?.content
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        view.backgroundColor = .white
        myDetailView.titleTextFieldView.delegate = self
        myDetailView.contentTextFieldView.delegate = self
    }
    
    func deleteNote() {
        if note != nil {
            context.delete(note!)
        }
    }
    
    func createNote() {
        let newNote = Note(context: context)
        newNote.content = myDetailView.contentTextFieldView.text
        newNote.title = myDetailView.titleTextFieldView.text
        do {
            try context.save()
        } catch {
            print("Failed save data \(error)")
        }
    }
    
    private func setupView() {
        let navigationbar = getNavigationbar()
        view.addSubview(navigationbar)
        view.addSubview(myDetailView)
        NSLayoutConstraint.activate([
            navigationbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            myDetailView.topAnchor.constraint(equalTo: navigationbar.bottomAnchor, constant: 0),
            myDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            myDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            myDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension DetailViewController {
    func getNavigationbar() -> UINavigationBar {
        let screenSize: CGRect = UIScreen.main.bounds
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        navbar.translatesAutoresizingMaskIntoConstraints = false
        UINavigationBar.appearance().barTintColor = .white
        let navItem = UINavigationItem()
        let rightBar = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        navItem.rightBarButtonItem = rightBar
        if note != nil {
            navItem.title = note?.title
        }
        navbar.setItems([navItem], animated: true)
        
        return navbar
    }
    
    @objc func onDone() {
        if myDetailView.titleTextFieldView.text == "" && myDetailView.contentTextFieldView.text == "" {
            deleteNote()
        } else if note == nil {
            createNote()
        }
        self.dismiss(animated: true)
    }
}

