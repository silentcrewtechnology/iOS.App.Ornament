//
//  TitleCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class TitleCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var titleView: TitleView?
    private var viewProperties = TitleView.ViewProperties()
    private var style = TitleViewStyle(size: .small, color: .primary)
    private var size: TitleViewStyle.Size = .small
    private var color: TitleViewStyle.Color = .primary
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createTitleSection(),
            createInputTextSection(),
            createSizeSection(),
            createColorSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createTitleSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<TitleView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: .zero, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.titleView = cell.containedView
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
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Small", "Medium", "Large", "Extra large"],
            actions: [
                { [weak self] in self?.updateTitleViewStyle(size: .small) },
                { [weak self] in self?.updateTitleViewStyle(size: .medium) },
                { [weak self] in self?.updateTitleViewStyle(size: .large) },
                { [weak self] in self?.updateTitleViewStyle(size: .extraLarge) }
            ],
            headerTitle: Constants.componentSize
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Primary", "Secondary"],
            actions: [
                { [weak self] in self?.updateTitleViewStyle(color: .primary) },
                { [weak self] in self?.updateTitleViewStyle(color: .secondary) }
            ],
            headerTitle: Constants.componentColor
        )
    }
    
    private func updateTitleViewStyle(
        size: TitleViewStyle.Size? = nil,
        color: TitleViewStyle.Color? = nil
    ) {
        if let size = size {
            self.size = size
        }
        
        if let color = color {
            self.color = color
        }
    
        style = .init(size: self.size, color: self.color)
        style.update(viewProperties: &viewProperties)
        titleView?.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.title = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        titleView?.update(with: viewProperties)
    }
}
