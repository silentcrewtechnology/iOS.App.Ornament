//
//  InputPhoneNumberCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 11.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class InputPhoneNumberCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputPhoneNumberView: InputPhoneNumberView?
    private var viewProperties = InputPhoneNumberView.ViewProperties()
    private var style = InputPhoneNumberViewStyle.init(state: .default)
    private var state: InputPhoneNumberViewStyle.State = .default
    private var hintText: NSMutableAttributedString = .init(string: "")
    private lazy var hintViewProperties: OldHintView.ViewProperties = {
        var viewProperties = OldHintView.ViewProperties()
        let style = OldHintViewStyle()
        style.update(
            variant: .empty,
            viewProperties: &viewProperties
        )
        
        return viewProperties
    }()
    
    private lazy var dividerViewProperties: DividerView.ViewProperties = {
        var viewProperties = DividerView.ViewProperties()
        let style = DividerViewStyle(
            variant: .fixed(.init(width: 1, height: 20)),
            style: .main
        )
        style.update(viewProperties: &viewProperties)
        
        return viewProperties
    }()
    
    private lazy var delegate: PhoneNumberViewTextFieldDelegate = {
        let delegate = PhoneNumberViewTextFieldDelegate(
            onBeginEditing: { [weak self] text in
                guard let self else { return }
                self.updateInputPhoneNumberViewStyle(state: self.state, text: text)
            },
            onEndEditing: { [weak self] text in
                guard let self else { return }
                self.updateInputPhoneNumberViewStyle(state: self.state, text: text)
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

    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createPhoneNumberViewSection(),
            createHintInputTextSection(),
            createStateSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createPhoneNumberViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputPhoneNumberView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.viewProperties = InputPhoneNumberView.ViewProperties(
                    prefix: .icon(image: .ic24Call),
                    placeholder: .init(string: "Телефон или имя"),
                    hint: self.hintViewProperties,
                    divider: self.dividerViewProperties
                )
                self.viewProperties.clearButtonAction = {
                    self.clearText()
                }
                self.viewProperties.delegateAssigningClosure = { textField in
                    textField.delegate = self.delegate
                }
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputPhoneNumberView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.bottom.equalToSuperview().offset(16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createHintInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textFieldViewProperties = .init(
                    text: self.hintText,
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(self, action: #selector(self.onHintTextChange(textField:)), for: .editingChanged)
                    }
                )
                let inputTextStyle = InputViewStyle(state: .default, set: .simple)
                inputTextStyle.update(viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentHintText)
        return section
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Default", "Active", "Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputPhoneNumberViewStyle(state: .default) },
                { [weak self] in self?.updateInputPhoneNumberViewStyle(state: .active) },
                { [weak self] in self?.updateInputPhoneNumberViewStyle(state: .error) },
                { [weak self] in self?.updateInputPhoneNumberViewStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState
        )
    }

    private func updateInputPhoneNumberViewStyle(
        state: InputPhoneNumberViewStyle.State,
        text: String? = nil
    ) {
        self.state = state
        
        style = .init(state: state)
        style.update(viewProperties: &viewProperties)
        
        if state == .error {
            makeHintViewProperties()
        } else {
            viewProperties.hint = .init()
        }
        
        if let text = text {
            viewProperties.text = .init(string: text)
        }
        
        inputPhoneNumberView?.update(with: viewProperties)
    }
    
    private func clearText() {
        viewProperties.text = .init(string: "")
        style.update(viewProperties: &viewProperties)
        inputPhoneNumberView?.update(with: viewProperties)
    }
    
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
        viewProperties.text = .init(string: formattedText)
        updateInputPhoneNumberViewStyle(state: state, text: formattedText)
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
    
    private func makeHintViewProperties() {
        var hintVP = OldHintView.ViewProperties()
        let hintStyle = OldHintViewStyle()
        hintStyle.update(variant: .left(hintText), viewProperties: &hintVP)
        viewProperties.hint = hintVP
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintText = .init(string: textField.text ?? "")
        
        if state == .error {
            makeHintViewProperties()
            inputPhoneNumberView?.update(with: viewProperties)
        }
    }
}

// MARK: - PhoneNumberViewTextFieldDelegate

private class PhoneNumberViewTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // MARK: - Private properties
    
    private let onBeginEditing: (String?) -> Void
    private let onEndEditing: (String?) -> Void
    private let onShouldChangeCharacters: (UITextField, NSRange, String) -> Bool
    
    // MARK: - Life cycle
    
    public init(
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
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing(textField.text)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing(textField.text)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return onShouldChangeCharacters(textField, range, string)
    }
}
