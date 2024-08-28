//
//  ButtonAuthCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 05.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class ButtonAuthCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var authorizationButton: ButtonAuth?
    private var viewProperties: ButtonAuth.ViewProperties = .init(
        image: .init(resource: .authorizationButtonGosuslugi),
        title: NSMutableAttributedString(string: "Войти через Госуслуги"),
        onTap: { }
    )
    private var style: ButtonAuthStyle = .init(
        variant: .gosuslugi,
        state: .default,
        color: .accent
    )
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createAuthorizationButtonSection(),
            createInputTextSection(),
            createVariantSection(),
            createStateSection(),
            createColorSection()
        ]
    }
}
    
    // MARK: - ButtonAuth
extension ButtonAuthCellBuilder {
    private func createAuthorizationButtonSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ButtonAuth>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.authorizationButton = cell.containedView
                
                self.style.update(viewProperties: &self.viewProperties)
                self.authorizationButton?.update(with: self.viewProperties)
 
                cell.selectionStyle = .none
                
                self.authorizationButton?.snp.remakeConstraints{
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().offset(16)
                    $0.trailing.equalToSuperview().offset(-16)
                    $0.bottom.equalToSuperview().offset(-16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
}
    
// MARK: - InputText
extension ButtonAuthCellBuilder {
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textFieldViewProperties = .init(
                    text: self.viewProperties.title,
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
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentText)
        return section
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.title = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        authorizationButton?.update(with: viewProperties)
    }
}
    
// MARK: Styles
extension ButtonAuthCellBuilder {
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["gosuslugi", "abb"],
            actions: [
                { [weak self] in
                    self?.viewProperties.image = .init(resource: .authorizationButtonGosuslugi)
                    self?.viewProperties.title = NSMutableAttributedString(string: "Войти через Госуслуги")
                    self?.updateStyle(newVariant: .gosuslugi)
                },
                { [weak self] in
                    self?.viewProperties.image = .init(resource: .authorizationButtonAbb)
                    self?.viewProperties.title = NSMutableAttributedString(string: "Войти через личный кабинет")
                    self?.updateStyle(newVariant: .abb)
                }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "pressed"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newState: .default)
                },
                { [weak self] in
                    self?.updateStyle(newState: .pressed)
                }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["accent", "light"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newColor: .accent)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .light)
                }
            ],
            headerTitle: Constants.componentColor
        )
    }
    
    private func updateStyle(
        newVariant: ButtonAuthStyle.Variant? = nil,
        newState: ButtonAuthStyle.State? = nil,
        newColor: ButtonAuthStyle.Color? = nil
    ) {
        style.update(
            variant: newVariant,
            state: newState,
            color: newColor,
            viewProperties: &viewProperties)
        authorizationButton?.update(with: viewProperties)
    }
}
