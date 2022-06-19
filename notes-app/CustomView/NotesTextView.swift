//
//  Custom+UITextView.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

class NotesTextView: UIViewController {
    
    var textView: UITextView = UITextView()
    private var placeholderLabel : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.font = .italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = .lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
}

extension NotesTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
