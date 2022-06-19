//
//  UITextField+Extension.swift
//  notes-app
//
//  Created by Soultan Muhammad Albar on 17/06/22.
//

import UIKit


// MARK: - Properties

public extension UITextField {
    var isEmpty: Bool {
        return text?.isEmpty == true
    }
}

// MARK: - Methods

public extension UITextField {
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    func setPlaceholderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {return}
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }
    
    func addPaddingLeft(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
    }
    
    func addPaddingRight(_ padding: CGFloat) {
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }
    
    func setBorderWidthColorRadius(_ width: CGFloat, _ color: CGColor?, _ radius: CGFloat?) {
        layer.borderWidth = width
        if let borderColor = color {
            layer.borderColor = borderColor
        }
        if let borderRadius = radius {
            layer.cornerRadius = borderRadius
        }
       
    }
}

// MARK: - Methods CustomTextField

public extension UITextField {
    func normalTextField() {
        addPaddingLeft(8)
        addPaddingRight(8)
        setPlaceholderTextColor(.lightGray)
    }
}
