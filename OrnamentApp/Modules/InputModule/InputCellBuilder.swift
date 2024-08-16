//
//  InputTextCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 12.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class InputCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputView: InputView?
    private var viewProperties = InputView.ViewProperties()
    private var style = InputViewStyle.init(state: .default, set: .simple)
    private var state: InputViewStyle.State = .default
    private var set: InputViewStyle.Set = .simple
    private var hintViewProperties = HintView.ViewProperties()
    private var labelViewProperties: LabelView.ViewProperties? = .init()
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createInputTextSection(),
            createHintInputTextSection(),
            createStateSection(),
            createSetSection(),
            createLabelSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.viewProperties.textFieldViewProperties = .init(placeholder: .init(string: "Placeholder"))
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.height.greaterThanOrEqualTo(80)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 104
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        
        return section
    }
    
    private func createHintInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textFieldViewProperties = .init(
                    text: self.hintViewProperties.text ?? .init(string: ""),
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(self, action: #selector(self.onHintTextChange(textField:)), for: .editingChanged)
                    }
                )
                let inputTextStyle = InputViewStyle(state: .default, set: .simple)
                inputTextStyle.update(viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = .init(top: .zero, left: .zero, bottom: 16, right: .zero)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentHintText)
        return section
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Default", "Active" ,"Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(state: .default, labelViewProperties: self?.labelViewProperties) },
                { [weak self] in self?.updateInputViewStyle(state: .active, labelViewProperties: self?.labelViewProperties) },
                { [weak self] in
                    guard let self = self else { return }
                    self.updateInputViewStyle(state: .error(self.hintViewProperties), labelViewProperties: self.labelViewProperties)
                },
                { [weak self] in self?.updateInputViewStyle(state: .disabled, labelViewProperties: self?.labelViewProperties) }
            ],
            headerTitle: Constants.componentState
        )
    }
    
    private func createSetSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Simple", "Icon", "Prefix"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(set: .simple, labelViewProperties: self?.labelViewProperties)},
                { [weak self] in self?.updateInputViewStyle(set: .icon(.ic24Frame), labelViewProperties: self?.labelViewProperties)},
                { [weak self] in self?.updateInputViewStyle(set: .prefix(.init(string: "Prefix")), labelViewProperties: self?.labelViewProperties)}
            ],
            headerTitle: Constants.componentSet
        )
    }
    
    private func createLabelSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Off", "On"],
            actions: [
                { [weak self] in self?.updateInputViewStyle(labelViewProperties: nil)},
                { [weak self] in
                    var viewProperties = LabelView.ViewProperties(text: .init(string: "Label"))
                    let style = LabelViewStyle(variant: .default(customColor: nil), alignment: .left)
                    style.update(viewProperties: &viewProperties)
                    
                    self?.updateInputViewStyle(labelViewProperties: viewProperties)
                }
            ],
            headerTitle: Constants.componentLabel
        )
    }

    private func updateInputViewStyle(
        state: InputViewStyle.State? = nil,
        set: InputViewStyle.Set? = nil,
        labelViewProperties: LabelView.ViewProperties? = nil
    ) {
        if let state {
            self.state = state
        }
        
        if let set {
            self.set = set
        }
        
        if let labelViewProperties {
            self.labelViewProperties = labelViewProperties
        } else {
            self.labelViewProperties = nil
        }
        
        viewProperties.labelViewProperties = self.labelViewProperties
        style = .init(state: self.state, set: self.set)
        style.update(viewProperties: &viewProperties)
        inputView?.update(with: viewProperties)
    }

    @objc private func onTextChange(textField: UITextField) {
        viewProperties.textFieldViewProperties.text = .init(string: textField.text ?? "")
        style.update(viewProperties: &viewProperties)
        inputView?.update(with: viewProperties)
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintViewProperties.text = .init(string: textField.text ?? "")
        
        switch state {
        case .error(_):
            let hintStyle = HintViewStyle(variant: .left, color: .error)
            hintStyle.update(viewProperties: &hintViewProperties)
            updateInputViewStyle(state: .error(hintViewProperties))
        default:
            break
        }
    }
}
