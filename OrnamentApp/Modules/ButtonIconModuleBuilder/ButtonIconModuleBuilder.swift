//
//  ButtonIconModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 22.07.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView
import ImagesService

final class ButtonIconModuleBuilder: NSObject, CellBuilder {
    
    private lazy var buttonIconService: ButtonIconService = .init(
        viewProperties: .init(image: .ic24PlayFilled),
        style: .init(
            variant: .primary,
            size: .large,
            state: .default,
            color: .accent
        )
    )
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createButtonIconSection(),
            createVariantSection(),
            createSizeSection(),
            createStateSection(),
            createColorSection()
        ]
    }
}

// MARK: ButtonIcon
extension ButtonIconModuleBuilder {
    private func createButtonIconSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: UITableViewCell.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                cell.contentView.subviews.forEach { $0.removeFromSuperview() }
                cell.contentView.addSubview(buttonIconService.view)
                cell.selectionStyle = .none
                buttonIconService.view.snp.remakeConstraints {
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
extension ButtonIconModuleBuilder {
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["primary", "secondary"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newVariant: .primary)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .secondary)
                }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["large", "small"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newSize: .large, newImage: .ic24PlayFilled)
                },
                { [weak self] in
                    self?.updateStyle(newSize: .small, newImage: .ic16Close)
                }
            ],
            headerTitle: Constants.componentSize
        )
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "pressed", "disabled", "loading"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newState: .default)
                },
                { [weak self] in
                    self?.updateStyle(newState: .pressed)
                },
                { [weak self] in
                    self?.updateStyle(newState: .disabled)
                },
                { [weak self] in
                    self?.updateStyle(newState: .loading)
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
        newVariant: ButtonIconStyle.Variant? = nil,
        newSize: ButtonIconStyle.Size? = nil,
        newState: ButtonIconStyle.State? = nil,
        newColor: ButtonIconStyle.Color? = nil,
        newImage: UIImage? = nil
    ) {
        buttonIconService.update(
            newSize: newSize,
            newColor: newColor,
            newVariant: newVariant,
            newState: newState,
            newImage: newImage
        )
    }
}
