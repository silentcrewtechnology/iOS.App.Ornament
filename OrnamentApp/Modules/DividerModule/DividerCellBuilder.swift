//
//  DividerCellBuilder.swift
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

final class DividerCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var dividerView: DividerView?
    private var viewProperties = DividerView.ViewProperties()
    private var dividerStyle = DividerViewStyle.init(orientation: .horizontal, style: .secondary)
    private var orientation: DividerViewStyle.Orientation = .horizontal
    private var style: DividerViewStyle.Style = .secondary
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createDividerSection(),
            createStyleSection(),
            createVariantSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createDividerSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<DividerView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.dividerStyle.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.dividerView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().inset(8)
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(1)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createStyleSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Secondary", "Main", "Accent"],
            actions: [
                { [weak self] in self?.updateDividerStyle(style: .secondary) },
                { [weak self] in self?.updateDividerStyle(style: .main) },
                { [weak self] in self?.updateDividerStyle(style: .action) }
            ],
            headerTitle: Constants.componentStyle
        )
    }
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Horizontal", "Vertical"],
            actions: [
                { [weak self] in self?.updateDividerStyle(variant: .horizontal) },
                { [weak self] in self?.updateDividerStyle(variant: .vertical) }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func updateDividerStyle(
        style: DividerViewStyle.Style? = nil,
        variant: DividerViewStyle.Orientation? = nil
    ) {
        if let style = style {
            self.style = style
        }
        
        if let variant = variant {
            self.orientation = variant
        }
        
        dividerStyle = .init(orientation: self.orientation, style: self.style)
        dividerStyle.update(viewProperties: &viewProperties)
        dividerView?.update(with: viewProperties)
    }
}
