//
//  ChipsCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 09.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class ChipsCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var chipsView: ChipsView?
    private var viewProperties = ChipsView.ViewProperties(text: .init(string: "ChipsView"))
    private var style = ChipsViewStyle(selection: .default, state: .default, size: .small)
    private var selection: ChipsViewStyle.Selection = .default
    private var state: ChipsViewStyle.State = .default
    private var size: ChipsViewStyle.Size = .small
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createChipsSection(),
            createInputTextSection(),
            createSelectionSection(),
            createStateSection(),
            createSizeSection(),
            createImageSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createChipsSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ChipsView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }

                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.chipsView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.equalToSuperview().inset(8)
                    make.leading.equalToSuperview().inset(16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: "Component.Title".localized)
        return section
    }
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputTextView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputTextView.ViewProperties = .init()
                vp.textField.text = self.viewProperties.text
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
        section.makeHeader(title: "Component.Text.Title".localized)
        return section
    }
    
    private func createSelectionSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Off", "On"],
            actions: [
                { [weak self] in self?.updateChipsStyle(selection: .default) },
                { [weak self] in self?.updateChipsStyle(selection: .selected) }
            ],
            headerTitle: "Chips.Selection.Title".localized,
            viewWidth: 52
        )
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Default", "Pressed", "Disabled"],
            actions: [
                { [weak self] in self?.updateChipsStyle(state: .default) },
                { [weak self] in self?.updateChipsStyle(state: .pressed) },
                { [weak self] in self?.updateChipsStyle(state: .disabled) }
            ],
            headerTitle: "Chips.State.Title".localized,
            viewWidth: 86
        )
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Small", "Large"],
            actions: [
                { [weak self] in self?.updateChipsStyle(size: .small) },
                { [weak self] in self?.updateChipsStyle(size: .large) }
            ],
            headerTitle: "Chips.Size.Title".localized,
            viewWidth: 72
        )
    }
    
    private func createImageSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["None", "Left", "Right"],
            actions: [
                { [weak self] in self?.addIconView(view: nil) },
                { [weak self] in self?.addIconView(view: UIImageView(image: .ic16Tick), inRight: false) },
                { [weak self] in self?.addIconView(view: UIImageView(image: .ic16Close), inRight: true) }
            ],
            headerTitle: "Chips.State.Title".localized,
            viewWidth: 72
        )
    }
    
    private func updateChipsStyle(
        selection: ChipsViewStyle.Selection? = nil,
        state: ChipsViewStyle.State? = nil,
        size: ChipsViewStyle.Size? = nil
    ) {
        if let selection = selection {
            self.selection = selection
        }
        
        if let state = state {
            self.state = state
        }
        
        if let size = size {
            self.size = size
        }
        
        style = .init(selection: self.selection, state: self.state, size: self.size)
        style.update(viewProperties: &viewProperties)
        chipsView?.update(with: viewProperties)
    }
    
    private func addIconView(view: UIView?, inRight: Bool = true) {
        if let view = view {
            if inRight {
                viewProperties.rightView = view
                viewProperties.leftView = nil
            } else {
                viewProperties.leftView = view
                viewProperties.rightView = nil
            }
        } else {
            viewProperties.leftView = nil
            viewProperties.rightView = nil
        }
        
        style.update(viewProperties: &viewProperties)
        chipsView?.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.text = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        chipsView?.update(with: viewProperties)
    }
}
