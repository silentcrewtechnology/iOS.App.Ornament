//
//  ButtonPayCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 06.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView
import SnapKit

final class ButtonPayCellBuilder: NSObject, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var viewProperties = ButtonPay.ViewProperties()
    private var buttonPay: ButtonPay?
    private var style = ButtonPayStyle(type: .samsung)
    private var type: ButtonPayStyle.`Type` = .samsung
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createButtonPaySection(),
            createTypeSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createButtonPaySection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ButtonPay>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                cell.containedView.snp.remakeConstraints { make in
                    make.width.lessThanOrEqualTo(257)
                    make.height.equalTo(56)
                    make.leading.bottom.equalToSuperview().inset(16)
                }
                
                self.buttonPay = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createTypeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Samsung", "SBP", "Google", "Apple", "Yandex"],
            actions: [
                { [weak self] in self?.updateButtonPayStyle(type: .samsung) },
                { [weak self] in self?.updateButtonPayStyle(type: .sbp) },
                { [weak self] in self?.updateButtonPayStyle(type: .google) },
                { [weak self] in self?.updateButtonPayStyle(type: .apple) },
                { [weak self] in self?.updateButtonPayStyle(type: .yandex) }
            ],
            headerTitle: Constants.componentType
        )
    }
    
    private func updateButtonPayStyle(type: ButtonPayStyle.`Type`) {
        self.type = type
        
        style = .init(type: self.type)
        style.update(viewProperties: &viewProperties)
        buttonPay?.update(with: viewProperties)
    }
}
