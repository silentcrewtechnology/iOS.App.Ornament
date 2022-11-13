//
//  FilledButton.swift
//  AbbDesign
//
//  Created by Алексей Титов on 24.10.2022.
//

import UIKit

/// Кнопка заполненная сплошным цветом,
/// Шрифт и размер задавать самостоятельно
open class FilledButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(UIImage(color: .backgroundAction), for: .normal)
        setBackgroundImage(UIImage(color: .backgroundActionPressed), for: .highlighted)
        setBackgroundImage(UIImage(color: .backgroundDisabled), for: .disabled)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)
        setTitleColor(.white, for: .disabled)
        layer.cornerRadius = 6
        layer.masksToBounds = true
        titleLabel?.numberOfLines = 1
        titleEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        accessibilityIdentifier = "FilledButton"
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

