//
//  InputSelectCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 12.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class InputSelectCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputSelectView: InputSelectView?
    private var viewProperties = InputSelectView.ViewProperties()
    private var style = InputSelectViewStyle.init(state: .default)
    private var state: InputSelectViewStyle.State = .default
    private var hintText: NSMutableAttributedString = .init(string: "")
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createInputSelectViewSection(),
            createInputTextSection(),
            createHintInputTextSection(),
            createStateSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createInputSelectViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputSelectView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                let hintViewProperties: HintView.ViewProperties = {
                    var viewProperties = HintView.ViewProperties()
                    let style = HintViewStyle()
                    style.update(
                        variant: .empty,
                        viewProperties: &viewProperties
                    )
                    return viewProperties
                }()

                self.viewProperties = InputSelectView.ViewProperties(
                    placeholder: .init(string: "Placeholder"),
                    hint: hintViewProperties
                )
                self.viewProperties.inputTapAction = {
                    self.selectText()
                }
                self.viewProperties.clearButtonAction = {
                    self.clearText()
                }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputSelectView = cell.containedView
                
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
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputTextView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputTextView.ViewProperties = .init()
                vp.textField.text = self.viewProperties.text
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputTextViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
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
            with: GenericTableViewCellWrapper<InputTextView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputTextView.ViewProperties = .init()
                vp.textField.text = self.hintText
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onHintTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputTextViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
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
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Default", "Active" ,"Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputSelectViewStyle(state: .default) },
                { [weak self] in self?.updateInputSelectViewStyle(state: .active) },
                { [weak self] in self?.updateInputSelectViewStyle(state: .error) },
                { [weak self] in self?.updateInputSelectViewStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState,
            eachViewWidths: [82, 72, 68, 84, 18]
        )
    }

    private func updateInputSelectViewStyle(
        state: InputSelectViewStyle.State
    ) {
        self.state = state
        
        style = .init(state: state)
        style.update(viewProperties: &viewProperties)
        
        if state == .error {
            makeHintViewProperties()
        } else {
            viewProperties.hint = .init()
        }
        
        inputSelectView?.update(with: viewProperties)
    }
    
    private func clearText() {
        viewProperties.text = .init(string: "")
        style.update(viewProperties: &viewProperties)
        inputSelectView?.update(with: viewProperties)
    }
    
    private func selectText() {
        style = .init(state: .active)
        style.update(viewProperties: &viewProperties)
        inputSelectView?.update(with: viewProperties)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            let oldText = self.viewProperties.text
            self.viewProperties.text = oldText
            self.style = .init(state: .default)
            self.style.update(viewProperties: &self.viewProperties)
            self.inputSelectView?.update(with: self.viewProperties)
        }
    }
    
    private func makeHintViewProperties() {
        var hintVP = HintView.ViewProperties()
        let hintStyle = HintViewStyle()
        hintStyle.update(variant: .left(hintText), viewProperties: &hintVP)
        viewProperties.hint = hintVP
    }

    @objc private func onTextChange(textField: UITextField) {
        viewProperties.text = .init(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        inputSelectView?.update(with: viewProperties)
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintText = .init(string: textField.text ?? "")
        
        switch state {
        case .error:
            makeHintViewProperties()
            inputSelectView?.update(with: viewProperties)
        default:
            break
        }
    }
}
