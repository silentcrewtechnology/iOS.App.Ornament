//
//  FloatingTextField.swift
//  AbbDesign
//
//  Created by Алексей Титов on 24.10.2022.
//

import UIKit
import Foundation

open class FloatingTextField: UITextField {

    // MARK: - Subviews
    private var border = UIView()
    private var label = UILabel()
    var placeHolderSize: CGFloat = 14
    var offset: CGFloat = 8
    var animationDuration: TimeInterval = 0.25

    // MARK: - Private Properties
    private var scale: CGFloat {
        placeHolderSize / fontSize
    }

    private var fontSize: CGFloat {
        font?.pointSize ?? 0
    }

    private var labelHeight: CGFloat {
        ceil(font?.withSize(placeHolderSize).lineHeight ?? 0)
    }

    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }

    private var isEmpty: Bool {
        text?.isEmpty ?? true
    }

    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: offset + labelHeight, left: 0, bottom: offset, right: 0)
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "FloatingTextField"
        setupUI()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - UITextField
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }

    public override var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        updateLabel(animated: false)
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard !isFirstResponder else {
            return
        }

        label.transform = .identity
        label.frame = bounds.inset(by: textInsets)
    }

    // MARK: - Private Methods
    private func setupUI() {
        borderStyle = .none

        border.backgroundColor = .gray50
        border.isUserInteractionEnabled = false
        addSubview(border)

        label.textColor = .gray50
        label.font = font
        label.text = placeholder
        label.isUserInteractionEnabled = false
        addSubview(label)

        addTarget(self, action: #selector(handleEditing), for: .allEditingEvents)
    }

    @objc
    private func handleEditing() {
        updateLabel()
        updateBorder()
    }

    private func updateBorder() {
        let borderColor = isFirstResponder ? tintColor : .gray50
        UIView.animate(withDuration: animationDuration) {
            self.border.backgroundColor = borderColor
        }
    }

    private func updateLabel(animated: Bool = true) {
        let isActive = isFirstResponder || !isEmpty

        let offsetX = -label.bounds.width * (1 - scale) / 2
        let offsetY = -label.bounds.height * (1 - scale) / 2

        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - labelHeight - offset)
            .scaledBy(x: scale, y: scale)

        guard animated else {
            label.transform = isActive ? transform : .identity
            return
        }

        UIView.animate(withDuration: animationDuration) {
            self.label.transform = isActive ? transform : .identity
        }
    }
}
