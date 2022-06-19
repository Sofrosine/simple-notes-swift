//
//  HomeView.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

protocol HomeDelegate {
    func onSelectRow(note: Note?)
    func onDeleteRow(note: Note, index: Int)
}

class HomeView: UIView {
    
    var tableView: UITableView!
    var myNotes: [Note] = []
    var delegate: HomeDelegate!
    
    convenience init() {
        self.init(frame: .zero)
        setupTable()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
        ])
    }
    
    private func setupTable() {
        DispatchQueue.main.async {
            self.tableView = UITableView()
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
            self.tableView.register(CellNoteTableViewCell.self, forCellReuseIdentifier: "CellNote")
            self.tableView.backgroundColor = .white
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.setupView()
        }
    }
    
}


extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! CellNoteTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.cellData = myNotes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.onSelectRow(note: myNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.tableView.beginUpdates()
            self.delegate.onDeleteRow(note: self.myNotes[indexPath.row], index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
    
}
