//
//  AuthorizationButtonCellBuilder.swift
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

final class AuthorizationButtonCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var authorizationButton: AuthorizationButton?
    private var variant: AuthorizationButtonStyle.Variant = .gosuslugi
    private var isInversed = false
    private var viewProperties: AuthorizationButton.ViewProperties = .init(
        image: .ic24Book,
        title: NSMutableAttributedString(string: "Войти через Госуслуги"),
        onTap: { }
    )
    private var style: AuthorizationButtonStyle = .init(
        variant: .gosuslugi,
        isInversed: false
    )
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createAuthorizationButtonSection(),
            createInputTextSection(),
            createVariantSection(),
            createInversionSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createAuthorizationButtonSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<AuthorizationButton>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.authorizationButton = cell.containedView
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
                vp.textField.text = self.viewProperties.title
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
        section.makeHeader(title: Constants.componentText)
        return section
    }
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Gosuslugi", "Standart"],
            actions: [
                { [weak self] in self?.updateButtonStyle(variant: .gosuslugi, isInversed: nil) },
                { [weak self] in self?.updateButtonStyle(variant: .standart, isInversed: nil) }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createInversionSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["False", "True"],
            actions: [
                { [weak self] in self?.updateButtonStyle(variant: nil, isInversed: false) },
                { [weak self] in self?.updateButtonStyle(variant: nil, isInversed: true) }
            ],
            headerTitle: Constants.componentInversion
        )
    }
    
    private func updateButtonStyle(
        variant: AuthorizationButtonStyle.Variant?,
        isInversed: Bool?
    ) {
        if let variant = variant {
            self.variant = variant
        }
        
        if let isInversed = isInversed {
            self.isInversed = isInversed
        }
        
        style = .init(variant: self.variant, isInversed: self.isInversed)
        style.update(viewProperties: &viewProperties)
        authorizationButton?.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.title = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        authorizationButton?.update(with: viewProperties)
    }
}
