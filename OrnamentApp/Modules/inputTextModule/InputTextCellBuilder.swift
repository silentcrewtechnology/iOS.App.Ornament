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

final class InputTextCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var inputTextView: InputTextView?
    private var viewProperties = InputTextView.ViewProperties()
    private var style = InputTextViewStyle.init()
    private var state: InputTextViewStyle.State = .default
    private var hintText: NSMutableAttributedString = .init(string: "")
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createInputTextSection(),
            createHintInputTextSection(),
            createStateSection(),
            createImageSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputTextView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                let hintViewProperties: HintView.ViewProperties = {
                    var viewProperties = HintView.ViewProperties()
                    let style = HintViewStyle()
                    style.update(
                        variant: .empty,
                        viewProperties: &viewProperties
                    )
                    return viewProperties
                }()
                self.viewProperties = .init(hint: hintViewProperties)
                self.viewProperties.textField.placeholder = .init(string: "Placeholder")
                
                self.style.update(state: .default, viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)

                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
                self.inputTextView = cell.containedView
                
                cell.containedView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.bottom.equalToSuperview().offset(16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentText.localized)
        return section
    }
    
    private func createHintInputTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputTextView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputTextView.ViewProperties = .init()
                vp.textField.text = self.hintText
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onHintTextChange(textField:)), for: .editingChanged)
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
        section.makeHeader(title: Constants.componentHintText)
        return section
    }
    
    private func createStateSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Default", "Active" ,"Error", "Disabled"],
            actions: [
                { [weak self] in self?.updateInputTextViewStyle(state: .default) },
                { [weak self] in self?.updateInputTextViewStyle(state: .active) },
                { [weak self] in
                    guard let self = self else { return }
                    self.updateInputTextViewStyle(state: .error(self.hintText))
                },
                { [weak self] in self?.updateInputTextViewStyle(state: .disabled) }
            ],
            headerTitle: Constants.componentState,
            eachViewWidths: [82, 72, 68, 84, 18]
        )
    }
    
    private func createImageSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["None", "Right"],
            actions: [
                { [weak self] in self?.updateInputTextViewStyle(isImage: false) },
                { [weak self] in self?.updateInputTextViewStyle(isImage: true) },
            ],
            headerTitle: Constants.componentImage,
            eachViewWidths: [72, 72, 200]
        )
    }

    private func updateInputTextViewStyle(
        state: InputTextViewStyle.State? = nil,
        isImage: Bool = false
    ) {
        if let state = state {
            self.state = state
        }
        
        if isImage {
            viewProperties.rightViews = [
                {
                    let view = UIImageView(image: .ic24Car)
                    view.snp.makeConstraints { $0.size.equalTo(24) }
          
                    return view
                }()
            ]
        } else {
            viewProperties.rightViews = []
        }
        
        style.update(state: self.state, viewProperties: &viewProperties)
        inputTextView?.update(with: viewProperties)
    }

    @objc private func onTextChange(textField: UITextField) {
        viewProperties.textField.text = .init(string: textField.text ?? "")
        style.update(state: state, viewProperties: &viewProperties)
        inputTextView?.update(with: viewProperties)
    }
    
    @objc private func onHintTextChange(textField: UITextField) {
        hintText = .init(string: textField.text ?? "")
        
        switch state {
        case .error(_):
            var hintVP = HintView.ViewProperties()
            let hintStyle = HintViewStyle()
            hintStyle.update(variant: .left(hintText), viewProperties: &hintVP)
            
            state = .error(hintText)
            style.update(state: state, viewProperties: &viewProperties)
            viewProperties.hint = hintVP
            inputTextView?.update(with: viewProperties)
        default:
            break
        }
    }
}
