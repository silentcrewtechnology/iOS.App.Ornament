//
//  BorderLabeledInput.swift
//  Ornament
//
//  Created by Алексей Титов on 07.11.2022.
//

import UIKit

open class BorderLabeledInput: UIView {
    
    enum State {
        case active
        case edit
        case error
        case disabled
    }
    
    public var animationDuration: CGFloat = 0.2
    
    public let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .textS
        label.textColor = .contentSecondary
        label.textAlignment = .left
        label.numberOfLines = 1
        label.accessibilityIdentifier = "toplabel"
        return label
    }()
    
    public let textField: BorderRoundedTextField = {
        let textField = BorderRoundedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public let hint: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .textS
        label.textColor = .contentError
        label.textAlignment = .left
        label.numberOfLines = 0
        label.accessibilityIdentifier = "hint"
        label.text = " " // нужно для полной высоты инпута как по дизайн системе 
        return label
    }()
    
    // MARK: Constraints
    public lazy var topLabelBottomContraintToTextFieldTop: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: topLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: textField,
            attribute: .top,
            multiplier: 1,
            constant: -4
        )
        return constraint
    }()
    
    public lazy var textFieldTopContraintToViewTop: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: textField,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        return constraint
    }()
    
    public lazy var textFieldBottomContraintToViewBottom: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: textField,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        return constraint
    }()
    
    public lazy var textFieldBottomContraintToHintTop: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: textField,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: hint,
            attribute: .top,
            multiplier: 1,
            constant: -4
        )
        return constraint
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(topLabel)
        addSubview(textField)
        addSubview(hint)
        
        NSLayoutConstraint.activate([
            topLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            topLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            topLabel.topAnchor.constraint(equalTo: self.topAnchor),
            topLabelBottomContraintToTextFieldTop,
            
            textField.leftAnchor.constraint(equalTo: self.leftAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor),
            textFieldBottomContraintToHintTop,
            
            hint.leftAnchor.constraint(equalTo: self.leftAnchor),
            hint.rightAnchor.constraint(equalTo: self.rightAnchor),
            hint.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func hideTopLabel(animated: Bool) {
        if topLabel.isHidden { return }
        
        textFieldTopContraintToViewTop.isActive = true
        topLabelBottomContraintToTextFieldTop.isActive = false
        setNeedsLayout()
        if animated {
            UIView.animate(
                withDuration: animationDuration,
                animations: { [weak self] in
                    self?.topLabel.alpha = 0
                    self?.layoutIfNeeded()
                },
                completion: { [weak self] _ in
                    self?.topLabel.isHidden = true
                }
            )
        } else {
            topLabel.isHidden = true
            layoutIfNeeded()
        }
    }
    
    public func showTopLabel(animated: Bool) {
        if !topLabel.isHidden { return }
        topLabel.isHidden = false
        textFieldTopContraintToViewTop.isActive = false
        topLabelBottomContraintToTextFieldTop.isActive = true
        setNeedsLayout()
        if animated {
            UIView.animate(
                withDuration: animationDuration,
                animations: { [weak self] in
                    self?.topLabel.alpha = 1
                    self?.layoutIfNeeded()
                }
            )
        } else {
            layoutIfNeeded()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
