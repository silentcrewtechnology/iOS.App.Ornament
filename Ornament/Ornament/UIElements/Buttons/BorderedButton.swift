//
//  BorderedButton.swift
//  AbbDesign
//
//  Created by Алексей Титов on 24.10.2022.
//

import UIKit

/// Кнопка с прозрачным бэкграундом,
/// Шрифт и размер задавать самостоятельно
open class BorderedButton: UIButton {
    
    private var borderColorForEnabled: CGColor = UIColor.white.cgColor
    private var borderColorForHighlited: CGColor = UIColor.white.withAlphaComponent(0.5).cgColor
    private var borderColorForDisabled: CGColor = UIColor.white.withAlphaComponent(0.7).cgColor
    
    open override var isEnabled: Bool {
        didSet {
            isEnabled ? setNormalBorder() : setDisabledBorder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(UIImage(color: .clear), for: .normal)
        setBackgroundImage(UIImage(color: .clear), for: .highlighted)
        setBackgroundImage(UIImage(color: .clear), for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        setTitleColor(.white.withAlphaComponent(0.7), for: .disabled)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1.5
        addTarget(self, action: #selector(setHightlitedBorder), for: .touchDown)
        addTarget(self, action: #selector(setNormalBorder), for: .touchUpInside)
        addTarget(self, action: #selector(setNormalBorder), for: .touchCancel)
        titleLabel?.numberOfLines = 1
        
        accessibilityIdentifier = "BorderedButton"
    }
    
    /// Устанавливает цвет рамки для кнопки
    /// - Parameters:
    ///   - color: Принимает UIColor
    ///   - state: Принимает UIConrol.State
    func setBorderColor(_ color: UIColor, for state: UIControl.State) {
        switch state {
        case .normal:
            borderColorForEnabled = color.cgColor
        case .highlighted:
            borderColorForHighlited = color.cgColor
        case .disabled:
            borderColorForDisabled = color.cgColor
        default:
            break
        }
    }
    
    @objc private func setHightlitedBorder() {
        if !isEnabled { return }
        layer.borderColor = borderColorForHighlited
    }
    
    @objc private func setNormalBorder() {
        if !isEnabled { return }
        layer.borderColor = borderColorForEnabled
    }
    
    @objc private func setDisabledBorder() {
        layer.borderColor = borderColorForDisabled
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
