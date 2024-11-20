//
//  InputOTPCellBuilder.swift
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

final class InputOTPCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputOTPView: InputOTPView?
    private var viewProperties = InputOTPView.ViewProperties()
    private var items = [InputOTPItemView.ViewProperties]()
    private var itemStyle = InputOTPItemViewStyle()
    private var state: InputOTPItemViewStyle.State = .default
    private var hintText: NSMutableAttributedString = .init(string: "")
    private var textField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.isHidden = true
       
        return field
    }()
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createOTPViewSection(),
            createAmountViewSection(),
            createHintInputTextSection(),
            createStateSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createOTPViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputOTPView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.textField.delegate = self
                self.textField.addTarget(self, action: #selector(onTextChange(textField:)), for: .editingChanged)
                cell.containedView.update(with: self.viewProperties)
                cell.containedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fieldTapped)))
                cell.containedView.addSubview(textField)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputOTPView = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createAmountViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputAmountView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var viewProperties = InputAmountView.ViewProperties(
                    textFieldProperties: .init(
                        text: .init(string: "0"),
                        placeholder: .init(string: "0"),
                        delegateAssigningClosure: { textField in
                            textField.delegate = self
                            textField.addTarget(self, action: #selector(self.onAmountTextChange(textField:)), for: .editingChanged)
                        }),
                    isUserInteractionEnabled: true
                )
                
                let hintStyle = HintViewStyle(
                    variant: .left,
                    color: .default
                )
                
                let style = InputAmountViewStyle(
                    state: .default
                )
                
                style.update(
                    state: .default,
                    viewProperties: &viewProperties
                )
                
                cell.containedView.update(with: viewProperties)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentAmount)
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
                { [weak self] in self?.updateState(state: .default) },
                { [weak self] in self?.updateState(state: .active) },
                { [weak self] in self?.updateState(state: .error) },
                { [weak self] in self?.updateState(state: .disabled) }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func updateState(state: InputOTPItemViewStyle.State) {
        self.state = state
        
        for i in viewProperties.items.indices {
            itemStyle.update(state: state, viewProperties: &viewProperties.items[i])
        }
        
        if state == .error {
            makeHintViewProperties()
        } else {
            viewProperties.hint = .init()
        }
        
        inputOTPView?.update(with: viewProperties)
    }
    
    private func createItems(count: Int) -> [InputOTPItemView.ViewProperties] {
        var otpItems = [InputOTPItemView.ViewProperties]()
        
        for _ in 0..<count {
            var itemVP = InputOTPItemView.ViewProperties()
            itemStyle.update(state: state, viewProperties: &itemVP)
            otpItems.append(itemVP)
        }
        
        return otpItems
    }
    
    private func makeHintViewProperties() {
        var hintVP = OldHintView.ViewProperties()
        let hintStyle = OldHintViewStyle()
        hintStyle.update(variant: .left(hintText), viewProperties: &hintVP)
        viewProperties.hint = hintVP
    }
    
    @objc private func onAmountTextChange(textField: UITextField) {
        guard let count = Int(textField.text ?? "") else { return }
        
        viewProperties.items = createItems(count: count)
        inputOTPView?.update(with: viewProperties)
    }

    @objc private func onHintTextChange(textField: UITextField) {
        hintText = .init(string: textField.text ?? "")
        
        if state == .error {
            makeHintViewProperties()
            inputOTPView?.update(with: viewProperties)
        }
    }
    
    @objc private func onTextChange(textField: UITextField) {
        let text = (textField.text ?? "").map { "\($0)" }
        for i in viewProperties.items.indices {
            if i < text.count {
                viewProperties.items[i].text = .init(string: "\(text[i])")
                itemStyle.update(state: state, viewProperties: &viewProperties.items[i])
            } else {
                viewProperties.items[i].text = .init(string: "")
                itemStyle.update(state: state, viewProperties: &viewProperties.items[i])
            }
        }
        
        inputOTPView?.update(with: viewProperties)
    }
    
    @objc private func fieldTapped() {
        textField.becomeFirstResponder()
    }
}
