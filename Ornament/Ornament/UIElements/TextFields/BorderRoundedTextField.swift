//
//  BorderRoundedTextField.swift
//  AbbDesign
//
//  Created by Алексей Титов on 31.10.2022.
//

import Foundation
import UIKit

open class BorderRoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.borderStyle = .roundedRect
        self.textAlignment = .left
        self.layer.cornerRadius = 8
        self.borderStyle = .none
        self.backgroundColor = .gray50
        self.accessibilityIdentifier = "BorderRoundedTextField"
        setupStates()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public func setPlaceholderText(text: String) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray150,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)
        ]
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: attributes
        )
    }
    
    func setupStates() {
        self.addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
    }
    
    @objc private func didBeginEditing() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @objc private func didEndEditing() {
        if let text = text, text.isEmpty{
            self.backgroundColor = .gray50
            self.layer.borderWidth = 0
        }
    }
    
}
