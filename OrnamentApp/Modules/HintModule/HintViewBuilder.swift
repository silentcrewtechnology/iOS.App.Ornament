//
//  HintViewBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 13.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class HintViewBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    private var hintView: HintView?
    private var style = HintViewStyle(variant: .both,
                                      color: .default)
    
    private var viewProperties = HintView.ViewProperties(text: "Hint".attributed,
                                                         additionalText: "Hint".attributed)
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createHintViewSection(),
            createInputTextSection(),
            createInputAdditionalTextSection(),
            createVariantSection(),
            createColorSection()
        ]
    }
}

// MARK: HintView
extension HintViewBuilder {
    private func createHintViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<HintView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.hintView = cell.containedView
                
                self.style.update(viewProperties: &self.viewProperties)
                self.hintView?.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                
                self.hintView?.snp.remakeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().offset(16)
                    $0.trailing.equalToSuperview().offset(-16)
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

// MARK: - Input text
extension HintViewBuilder {
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                
                if let text = self.viewProperties.text {
                    vp.textField.text = text
                    vp.textField.delegateAssigningClosure = { textField in
                        textField.delegate = self
                        textField.addTarget(self, action: #selector(self.onTextChange(textField:)), for: .editingChanged)
                    }
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
        section.makeHeader(title: Constants.hintText)
        return section
    }
    
    @objc private func onTextChange(textField: UITextField) {
        viewProperties.text = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        hintView?.update(with: viewProperties)
    }
}

// MARK: - Input additionalText
extension HintViewBuilder {
    private func createInputAdditionalTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                
                if let additionalText = self.viewProperties.additionalText {
                    vp.textField.text = additionalText
                    vp.textField.delegateAssigningClosure = { textField in
                        textField.delegate = self
                        textField.addTarget(self, action: #selector(self.onAdditionalTextChange(textField:)), for: .editingChanged)
                    }
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
        section.makeHeader(title: Constants.hintAdditionalText)
        return section
    }
    
    @objc private func onAdditionalTextChange(textField: UITextField) {
        viewProperties.additionalText = NSMutableAttributedString(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        hintView?.update(with: viewProperties)
    }
}

// MARK: Styles
extension HintViewBuilder {
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["both", "center", "left", "right", "empty"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newVariant: .both)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .center)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .left)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .right)
                },
                { [weak self] in
                    self?.updateStyle(newVariant: .empty)
                }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["default", "active", "error", "disabled"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newColor: .default)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .active)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .error)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .disabled)
                }
            ],
            headerTitle: Constants.componentColor
        )
    }
    
    private func updateStyle(
        newVariant: HintViewStyle.Variant? = nil,
        newColor: HintViewStyle.Color? = nil
    ) {
        style.update(
            variant: newVariant,
            color: newColor,
            viewProperties: &viewProperties)
        hintView?.update(with: viewProperties)
    }
}
