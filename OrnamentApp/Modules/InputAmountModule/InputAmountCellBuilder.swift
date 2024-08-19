//
//  InputAmountCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 10.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class InputAmountCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputAmountView: InputAmountView?
    private var viewProperties = InputAmountView.ViewProperties(
        textFieldProperties: .init(placeholder: .init(string: "0")),
        amountSymbol: .init(string: "₽")
    )
    private var style = InputAmountViewStyle.init()
    private var state: InputAmountViewStyle.State = .default
    private var hintText: NSMutableAttributedString = .init(string: "")
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createAmountViewSection(),
            createInputTextSection(),
            createHintInputTextSection(),
            createStateSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createAmountViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputAmountView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(state: .default, viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputAmountView = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textFieldViewProperties = .init(
                    text: self.viewProperties.textFieldProperties.text,
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: .editingChanged)
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
        section.makeHeader(title: Constants.componentText.localized)
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
            titles: ["Default", "Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputAmountViewStyle(state: .default) },
                { [weak self] in
                    guard let self = self else { return }
                    self.updateInputAmountViewStyle(state: .error(self.hintText))
                },
                { [weak self] in self?.updateInputAmountViewStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState
        )
    }

    private func updateInputAmountViewStyle(
        state: InputAmountViewStyle.State
    ) {
        self.state = state
        
        style.update(state: self.state, viewProperties: &viewProperties)
        inputAmountView?.update(with: viewProperties)
    }

    @objc private func onTextChange(textField: UITextField) {
        viewProperties.textFieldProperties.text = .init(string: textField.text ?? "")
        style.update(state: state, viewProperties: &viewProperties)
        inputAmountView?.update(with: viewProperties)
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintText = .init(string: textField.text ?? "")
        
        switch state {
        case .error(_):
            var hintVP = OldHintView.ViewProperties()
            let hintStyle = OldHintViewStyle()
            hintStyle.update(variant: .left(hintText), viewProperties: &hintVP)
            
            state = .error(hintText)
            style.update(state: state, viewProperties: &viewProperties)
            viewProperties.hint = hintVP
            inputAmountView?.update(with: viewProperties)
        default:
            break
        }
    }
}
