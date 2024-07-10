//
//  ToggleCellBuilder.swift
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

final class ToggleCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var toggleView: ToggleView?
    private var viewProperties = ToggleView.ViewProperties()
    private var style = ToggleViewStyle.init(state: .default)
    private var state: ToggleViewStyle.State = .default
    private var isChecked = false
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createToggleSection(),
            createStateSection(),
            createCheckedSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createToggleSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ToggleView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.toggleView = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Default", "Pressed", "Disabled"],
            actions: [
                { [weak self] in self?.updateToggleStyle(state: .default) },
                { [weak self] in self?.updateToggleStyle(state: .default) }, // Заменить на состояние pressed
                { [weak self] in self?.updateToggleStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState,
            viewWidth: 92
        )
    }
    
    private func createCheckedSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["False", "True"],
            actions: [
                { [weak self] in self?.updateToggleStyle(isChecked: false) },
                { [weak self] in self?.updateToggleStyle(isChecked: true) }
            ],
            headerTitle: Constants.componentChecked,
            viewWidth: 64
        )
    }
    
    private func updateToggleStyle(
        state: ToggleViewStyle.State? = nil,
        isChecked: Bool? = nil
    ) {
        if let state = state {
            self.state = state
        }
        
        if let isChecked = isChecked {
            self.isChecked = isChecked
        }
    
        style = .init(state: self.state)
        style.update(viewProperties: &viewProperties)
        viewProperties.isChecked = self.isChecked
        toggleView?.update(with: viewProperties)
    }
}
