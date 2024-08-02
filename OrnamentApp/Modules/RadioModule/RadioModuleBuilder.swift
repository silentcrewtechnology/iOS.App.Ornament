//
//  RadioModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 01.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class RadioModuleBuilder: NSObject, CellBuilder {
    
    private var radioView: RadioView?
    private var style = RadioViewStyle(state: .default,
                                       selection: .default)
    private var viewProperties = RadioView.ViewProperties()
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createRadioViewSection(),
            createStateSection(),
            createSelectionSection()
        ]
    }
}

// MARK: RadioView
extension RadioModuleBuilder {
    private func createRadioViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<RadioView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.radioView = cell.containedView
                
                self.style.update(state: .default,
                                  selection: .default,
                                  viewProperties: &self.viewProperties)
                
                self.radioView?.update(with: self.viewProperties)
                cell.selectionStyle = .none
                
                self.radioView?.snp.remakeConstraints{
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
extension RadioModuleBuilder {
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "pressed", "disabled"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newState: .default)
                },
                { [weak self] in
                    self?.updateStyle(newState: .pressed)
                },
                { [weak self] in
                    self?.updateStyle(newState: .disabled)
                }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func createSelectionSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "checked"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newSelection: .default)
                },
                { [weak self] in
                    self?.updateStyle(newSelection: .checked)
                }
            ],
            headerTitle: Constants.componentSelection
        )
    }
    
    private func updateStyle(
        newState: RadioViewStyle.State? = nil,
        newSelection: RadioViewStyle.Selection? = nil
    ) {
        style.update(
            state: newState,
            selection: newSelection,
            viewProperties: &viewProperties)
        radioView?.update(with: viewProperties)
        radioView?.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
