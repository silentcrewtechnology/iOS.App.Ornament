//
//  DSTextFieldDelegate.swift
//  AbbDesign
//
//  Created by Алексей Титов on 31.10.2022.
//

import UIKit

open class OnlyUppercasedTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    @objc public func textChange(_ textField: UITextField) {
        let text = textField.text
        textField.text = text?.uppercased()
    }
}
