//
//  NumberInputTextFieldDelegate.swift
//  AbbDesign
//
//  Created by Алексей Титов on 24.10.2022.
//

import Foundation
import UIKit


/// Делегат для ввода только цифр в поле ввода
open class NumberInputTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}
