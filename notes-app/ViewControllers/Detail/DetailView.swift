//
//  DetailView.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

class DetailView: UIView {
    
    var titleTextFieldView: UITextField {
        titleTextField
    }
    
    var contentTextFieldView: UITextView {
        contentTextField
    }
    
    private lazy var titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "Enter your title notes..."
        titleTextField.normalTextField()
        titleTextField.font = UIFont(name: "Helvetica", size: 24)
        
        return titleTextField
    }()
    
    private lazy var contentTextField: UITextView = {
        let contentTextField = UITextView()
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextField.wrapToContent()
        contentTextField.font = UIFont(name: "Helvetica", size: 18)

        
        return contentTextField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(contentTextField)
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupView()
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
