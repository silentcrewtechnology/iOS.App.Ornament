//
//  BadgeModuleBuilder.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 11.07.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class BadgeModuleBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    private var badge: BadgeView?
    private var style = BadgeStyle(color: .neutral, size: .large, set: .full)
    private var viewProperties = BadgeView.ViewProperties(text: "23 +".attributed, image: .ic16Tick)
    private let badgeImage: UIImage = .ic16Tick
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var textFieldText: NSMutableAttributedString = "23 +".attributed
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createBadgeSection(),
            createInputTextSection(),
            createColorSection(),
            createSizeSection(),
            createSetSection()
        ]
    }
}

// MARK: Badge
extension BadgeModuleBuilder {
    private func createBadgeSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<BadgeView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                cell.selectionStyle = .none
                self.badge = cell.containedView
                
                cell.containedView.snp.remakeConstraints {
                    $0.leading.top.equalToSuperview().offset(16)
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

// MARK: TextField
extension BadgeModuleBuilder {
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textFieldViewProperties = .init(
                    text: self.viewProperties.text ?? .init(string: ""),
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
    
    
    @objc private func onTextChange(textField: UITextField) {
        textFieldText = NSMutableAttributedString(string: textField.text ?? "")
        viewProperties.text = textFieldText
        style.update(viewProperties: &viewProperties)
        badge?.update(with: viewProperties)
        badge?.snp.remakeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
    }
}

// MARK: Styles
extension BadgeModuleBuilder {
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["neutral", "accent", "accentBrand", "accentInfo"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newColor: .neutral)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .accent)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .accentBrand)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .accentInfo)
                }
            ],
            headerTitle: Constants.componentColor
        )
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["large", "small"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newSize: .large)
                },
                { [weak self] in
                    self?.updateStyle(newSize: .small)
                }
            ],
            headerTitle: Constants.componentSize
        )
    }
    
    private func createSetSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["full", "basic", "simple"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newSet: .full)
                },
                { [weak self] in
                    self?.updateStyle(newSet: .basic)
                },
                { [weak self] in
                    self?.updateStyle(newSet: .simple)
                }
            ],
            headerTitle: Constants.componentSet
        )
    }
    
    private func updateStyle(
        newColor: BadgeStyle.Color? = nil,
        newSize: BadgeStyle.Size? = nil,
        newSet: BadgeStyle.Set? = nil
    ) {
        viewProperties.text = textFieldText
        viewProperties.image = badgeImage
        style.update(
            newColor: newColor,
            newSize: newSize,
            newSet: newSet,
            viewProperties: &viewProperties)
        badge?.update(with: viewProperties)
        badge?.snp.remakeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
    }
}
