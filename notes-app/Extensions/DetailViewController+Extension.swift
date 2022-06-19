//
//  DetailViewController+Extension.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textValue = textField.text {
            note?.title = textValue
            do {
                try context.save()
            } catch {
                print("Failed save data \(error)")
            }
        }
    }
    
}


extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if let textValue = textView.text {
            note?.content = textValue
            do {
                try context.save()
            } catch {
                print("Failed save data \(error)")
            }
        }
    }
    
    
    
}
