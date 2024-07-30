//
//  InputPhoneNumberViewExampleVC.swift
//
//
//  Created by Ilnur Mugaev on 12.04.2024.
//

import UIKit
import Components
import DesignSystem

private final class InputPhoneNumberViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var headerViewProperties: LabelView.ViewProperties = {
        var viewProperties = LabelView.ViewProperties(text: .init(string: "Header"))
        let style = LabelViewStyle(variant: .default)
        style.update(viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var hintViewProperties: HintView.ViewProperties = {
        var viewProperties = HintView.ViewProperties()
        let style = HintViewStyle()
        style.update(
            variant: .empty,
            viewProperties: &viewProperties
        )
        return viewProperties
    }()
    
    private lazy var dividerViewProperties: DividerView.ViewProperties = {
        var viewProperties = DividerView.ViewProperties()
        let style = DividerViewStyle(
            orientation: .fixed(.init(width: 1, height: 20)),
            style: .main
        )
        style.update(viewProperties: &viewProperties)
        return viewProperties
    }()
    
    private lazy var style: InputPhoneNumberViewStyle = .init(state: .default)
    
    private lazy var viewProperties: InputPhoneNumberView.ViewProperties = {
        var viewProperties = InputPhoneNumberView.ViewProperties(
            header: headerViewProperties,
            prefix: .icon(image: .ic24Call),
            placeholder: "Телефон или имя".attributed,
            hint: hintViewProperties,
            divider: dividerViewProperties
        )
        
        viewProperties.delegateAssigningClosure = { [weak self] textField in
            guard let self else { return }
            textField.delegate = self.delegate
        }
        
        viewProperties.clearButtonAction = { [weak self] in
            guard let self else { return }
            self.clearText()
        }
        
        style = .init(state: .default)
        style.update(viewProperties: &viewProperties)
        
        return viewProperties
    }()
    
    private lazy var delegate: PhoneNumberViewTextFieldDelegate = {
        let delegate = PhoneNumberViewTextFieldDelegate(
            onBeginEditing: { [weak self] text in
                guard let self else { return }
                self.updateView(state: .active, text: text)
            },
            onEndEditing: { [weak self] text in
                guard let self else { return }
                self.updateView(state: .default, text: text)
            },
            onShouldChangeCharacters: { [weak self] textField, range, string in
                guard let self else { return true }
                switch self.viewProperties.prefix {
                case .icon:
                    return self.handleIconPrefix(
                        textField: textField,
                        shouldChangeCharactersIn: range,
                        replacementString: string
                    )
                case .country:
                    /// Добавить логику для работы префиксом .country
                    return true
                }
            }
        )
        return delegate
    }()
    
    private lazy var inputPhoneNumberView: InputPhoneNumberView = {
        let view = InputPhoneNumberView()
        view.update(with: viewProperties)
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(inputPhoneNumberView)
        inputPhoneNumberView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.topMargin.equalToSuperview().inset(20)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private methods
    
    private func handleIconPrefix(
        textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        if range.location == 0 && string.isEmpty {
            textField.text = ""
            clearText()
            return false
        }
        
        let newText = text.replacingCharacters(in: textRange, with: string)
        
        if newText.count == 1 && newText == "+" {
            textField.text = ""
            clearText()
            return false
        }
        
        handleFormattedText(formatDigitsWithPrefix(newText), textField: textField)
        
        return false
    }
    
    private func handleFormattedText(_ formattedText: String?, textField: UITextField) {
        guard let formattedText = formattedText else { return }
        textField.text = formattedText
        viewProperties.text = formattedText.attributed
        updateView(state: .active, text: formattedText)
    }
    
    private func formatDigitsWithPrefix(_ text: String) -> String? {
        let digitsOnly = text.replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression)
        
        if digitsOnly.count > 12 {
            return nil
        }
        
        let formattedText = digitsOnly.starts(with: "+") ? digitsOnly : "+\(digitsOnly)"
        
        return formattedText.enumerated().compactMap { index, digit -> String in
            var formattedDigit = String(digit)
            if index == 2 {
                formattedDigit = " (\(formattedDigit)"
            } else if index == 5 {
                formattedDigit = ") \(formattedDigit)"
            } else if index == 8 || index == 10 {
                formattedDigit = "-\(formattedDigit)"
            }
            return formattedDigit
        }.joined()
    }
    
    private func updateView(state: InputPhoneNumberViewStyle.State, text: String?) {
        style = .init(state: state)
        viewProperties.text = text?.attributed
        style.update(viewProperties: &viewProperties)
        inputPhoneNumberView.update(with: viewProperties)
    }
    
    private func clearText() {
        viewProperties.text = "".attributed
        style.update(viewProperties: &viewProperties)
        inputPhoneNumberView.update(with: viewProperties)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - PhoneNumberViewTextFieldDelegate

private final class PhoneNumberViewTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Private properties
    
    private let onBeginEditing: (String?) -> Void
    private let onEndEditing: (String?) -> Void
    private let onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    // MARK: - Life cycle
    
    init(
        onBeginEditing: @escaping (String?) -> Void,
        onEndEditing: @escaping (String?) -> Void,
        onShouldChangeCharacters: @escaping (UITextField, NSRange, String) -> Bool
    ) {
        self.onBeginEditing = onBeginEditing
        self.onEndEditing = onEndEditing
        self.onShouldChangeCharacters = onShouldChangeCharacters
        
        super.init()
    }
    
    // MARK: - Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing(textField.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing(textField.text)
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return onShouldChangeCharacters(textField, range, string)
    }
}
