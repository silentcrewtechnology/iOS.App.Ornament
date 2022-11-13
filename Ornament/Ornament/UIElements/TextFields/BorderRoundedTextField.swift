//
//  BorderRoundedTextField.swift
//  AbbDesign
//
//  Created by Алексей Титов on 31.10.2022.
//

import Foundation
import UIKit

/// Поле ввода со скругленныеми краями и
/// рамкой со сменяющимися цветами при редактировании
open class BorderRoundedTextField: UITextField {

    let padding = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    /// leftView и rightView по умолчанию должны принимать элементы размером 24х24
    let leftViewPadding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 8)
    /// leftView и rightView по умолчанию должны принимать элементы размером 24х24
    let rightViewPadding = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 12)
    
    public var animationDuration = 0.2

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
        self.backgroundColor = .backgroundPrimary
        self.accessibilityIdentifier = "BorderRoundedTextField"
        setupStates()
    }

    
    public func setPlaceholderText(text: String) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.contentTertiary,
            NSAttributedString.Key.font: UIFont.textL
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
        updateBorder(toWidth: 1,
                     toColor: .borderAction)
    }
    
    @objc private func didEndEditing() {
        if let text = text, text.isEmpty{
            self.backgroundColor = .backgroundPrimary
            updateBorder(toWidth: 0,
                         toColor: UIColor(cgColor: layer.borderColor!))
        } else {
            updateBorder(toWidth: layer.borderWidth,
                         toColor: .backgroundPrimary)
            self.backgroundColor = .backgroundPrimary
        }
        
    }
    
    public func updateBorder(animated: Bool = true,
                             toWidth: CGFloat,
                             toColor: UIColor) {
        
        if animated {
            let borderColorAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
            borderColorAnimation.fromValue = layer.borderColor
            borderColorAnimation.toValue = toColor.cgColor
            borderColorAnimation.duration = animationDuration
            layer.add(borderColorAnimation, forKey: "borderColor")
            layer.borderColor = toColor.cgColor
            
            let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
            borderWidthAnimation.fromValue = layer.borderWidth
            borderWidthAnimation.toValue = toWidth
            borderWidthAnimation.duration = animationDuration
            layer.add(borderWidthAnimation, forKey: "borderWidth")
            layer.borderWidth = toWidth
        } else {
            layer.borderColor = toColor.cgColor
            layer.borderWidth = toWidth
        }
    }
    
    //MARK: Override
    
    private func setInsets(forBounds bounds: CGRect) -> CGRect {

        var totalInsets = padding

        if let leftView = leftView  {
            totalInsets.left += leftView.frame.width + leftViewPadding.right
        }
        if let rightView = rightView {
            totalInsets.right += rightView.bounds.size.width + rightViewPadding.left
        }

        return bounds.inset(by: totalInsets)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }

    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {

        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= rightViewPadding.right
        
        return rect
    }

    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {

        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += leftViewPadding.left

        return rect
    }
}
