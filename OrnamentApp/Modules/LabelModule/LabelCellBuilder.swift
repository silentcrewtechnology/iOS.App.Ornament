//
//  LabelCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 13.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView
import SnapKit
import Services

final class LabelCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private let recognizerService = GestureRecognizerService()
    private var viewProperties = LabelView.ViewProperties()
    private var style = LabelViewStyle(variant: .default(customColor: nil), alignment: .left)
    private var labelView: LabelView?
    private var variant: LabelViewStyle.Variant = .default(customColor: nil)
    private var alignment: NSTextAlignment = .left
    private var isCopied = false
    private var gestureRecognizer: UILongPressGestureRecognizer?
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        gestureRecognizer = recognizerService.createRecognizerForCopy { [weak self] in
            self?.viewProperties.text.string
        }
        
        return [
            createLabelSection(),
            createInputTextSection(),
            createVariantSection(),
            createAlignmentSection(),
            createCopySection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createLabelSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<LabelView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                self.labelView = cell.containedView
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
                vp.textField.text = self.viewProperties.text
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
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
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Default", "Disabled", "Row title", "Row subtitle", "Row index", "Row amount", "Blocked status", "Re-release status", "Expires status", "Readiness status"],
            actions: [
                { [weak self] in self?.updateLabelViewStyle(variant: .default(customColor: nil)) },
                { [weak self] in self?.updateLabelViewStyle(variant: .disabled(customColor: nil)) },
                { [weak self] in
                    guard let self else { return }
                    self.updateLabelViewStyle(variant: .rowTitle(recognizer: self.isCopied ? self.gestureRecognizer : nil))
                },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowSubtitle) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowIndex) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowAmount) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowStatusCard(statusCardVariant: .blocked)) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowStatusCard(statusCardVariant: .rerelease)) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowStatusCard(statusCardVariant: .expires)) },
                { [weak self] in self?.updateLabelViewStyle(variant: .rowStatusCard(statusCardVariant: .readiness)) }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createAlignmentSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Left", "Center", "Right"],
            actions: [
                { [weak self] in self?.updateLabelViewStyle(alignment: .left) },
                { [weak self] in self?.updateLabelViewStyle(alignment: .center) },
                { [weak self] in self?.updateLabelViewStyle(alignment: .right) }
            ],
            headerTitle: Constants.componentAlignment
        )
    }
    
    private func createCopySection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["False", "True"],
            actions: [
                { [weak self] in
                    guard let self else { return }
                    
                    self.isCopied = false
                    switch self.variant {
                    case .rowTitle(_):
                        self.variant = .rowTitle(recognizer: nil)
                    default: break
                    }
                    
                    self.updateLabelViewStyle()
                },
                { [weak self] in
                    guard let self else { return }
                    
                    self.isCopied = true
                    switch self.variant {
                    case .rowTitle(_):
                        self.variant = .rowTitle(recognizer: self.gestureRecognizer)
                    default: break
                    }
                    
                    self.updateLabelViewStyle()
                }
            ],
            headerTitle: Constants.componentCopy
        )
    }
    
    private func updateLabelViewStyle(
        variant: LabelViewStyle.Variant? = nil,
        alignment: NSTextAlignment? = nil
    ) {
        if let variant {
            self.variant = variant
        }

        if let alignment {
            self.alignment = alignment
        }
        
        style = .init(variant: self.variant, alignment: self.alignment)
        style.update(viewProperties: &viewProperties)
        labelView?.update(with: viewProperties)
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.text = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        labelView?.update(with: viewProperties)
    }
}
