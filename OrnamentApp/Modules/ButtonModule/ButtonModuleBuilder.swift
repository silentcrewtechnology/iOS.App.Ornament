//
//  ButtonModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 06.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class ButtonModuleBuilder: NSObject, CellBuilder {
    
    private var buttonView: ButtonView?
    private var style = ButtonViewStyle(size: .large,
                                        color: .accent,
                                        variant: .primary,
                                        state: .default,
                                        icon: .without)
    
    private var viewProperties = ButtonView.ViewProperties(attributedText: "Label".attributed)
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createButtonViewSection(),
            createSizeSection(),
            createColorSection(),
            createVariantSection(),
            createStateSection(),
            createIconSection()
        ]
    }
}

// MARK: ButtonView
extension ButtonModuleBuilder {
    private func createButtonViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ButtonView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.buttonView = cell.containedView
                
                self.style.update(viewProperties: &self.viewProperties)
                self.buttonView?.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                
                self.buttonView?.snp.remakeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().offset(16)
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

// MARK: Styles
extension ButtonModuleBuilder {
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["large", "small"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newSize: .large)
                },
                { [weak self] in
                    self?.updateStyle(newSize: .small)
                }
            ],
            headerTitle: Constants.componentSize
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
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["primary", "secondary", "tertiary", "function"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newVariant: .primary)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .secondary)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .tertiary)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .function)
                }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "pressed", "disabled", "loading"],
            actions: [
                { [weak self] in
                    self?.viewProperties.attributedText = "Label".attributed
                    self?.updateStyle(newState: .default)
                },
                { [weak self] in
                    self?.viewProperties.attributedText = "Label".attributed
                    self?.updateStyle(newState: .pressed)
                },
                { [weak self] in
                    self?.viewProperties.attributedText = "Label".attributed
                    self?.updateStyle(newState: .disabled)
                },
                { [weak self] in
                    self?.updateStyle(newState: .loading)
                }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func createIconSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["without", "with"],
            actions: [
                { [weak self] in
                    self?.viewProperties.leftIcon = nil
                    self?.updateStyle(newIcon: .without)
                },
                { [weak self] in
                    self?.updateStyle(newIcon: .with(.ic24PlayFilled))
                }
            ],
            headerTitle: Constants.componentIcon
        )
    }
    
    private func updateStyle(
        newSize: ButtonViewStyle.Size? = nil,
        newColor: ButtonViewStyle.Color? = nil,
        newVariant: ButtonViewStyle.Variant? = nil,
        newState: ButtonViewStyle.State? = nil,
        newIcon: ButtonViewStyle.Icon? = nil
    ) {
        style.update(
            size: newSize,
            color: newColor,
            variant: newVariant,
            state: newState,
            icon: newIcon,
            viewProperties: &viewProperties)
        buttonView?.update(with: viewProperties)
    }
}
