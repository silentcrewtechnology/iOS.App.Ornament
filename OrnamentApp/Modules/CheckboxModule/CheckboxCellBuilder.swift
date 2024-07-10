//
//  CheckboxCellBuilder\.swift
//  OrnamentApp
//
//  Created by user on 08.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class CheckboxCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var checkboxView: CheckboxView?
    private var viewProperties = CheckboxView.ViewProperties()
    private var style = CheckboxViewStyle(selection: .default, state: .default)
    private var selection: CheckboxViewStyle.Selection = .default
    private var state: CheckboxViewStyle.State = .default
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createCheckboxSection(),
            createSelectionSection(),
            createStateSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createCheckboxSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<CheckboxView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.checkboxView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().inset(8)
                    make.leading.equalToSuperview().inset(16)
                    make.size.equalTo(24)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createSelectionSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Off", "On"],
            actions: [
                { [weak self] in self?.updateCheckboxStyle(selection: .default) },
                { [weak self] in self?.updateCheckboxStyle(selection: .checked) }
            ],
            headerTitle: Constants.componentChecked,
            viewWidth: 52
        )
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Default", "Pressed", "Disabled"],
            actions: [
                { [weak self] in self?.updateCheckboxStyle(state: .default) },
                { [weak self] in self?.updateCheckboxStyle(state: .pressed) },
                { [weak self] in self?.updateCheckboxStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState,
            viewWidth: 86
        )
    }
    
    private func updateCheckboxStyle(
        selection: CheckboxViewStyle.Selection? = nil,
        state: CheckboxViewStyle.State? = nil
    ) {
        if let selection = selection {
            self.selection = selection
        }
        
        if let state = state {
            self.state = state
        }
        
        style = .init(selection: self.selection, state: self.state)
        style.update(viewProperties: &viewProperties)
        checkboxView?.update(with: viewProperties)
    }
}
