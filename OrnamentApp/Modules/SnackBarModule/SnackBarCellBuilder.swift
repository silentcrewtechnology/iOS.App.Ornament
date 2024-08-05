//
//  SnackBarCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 05.08.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class SnackBarCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {

    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var snackBarView: SnackBarView?
    private var style = SnackBarViewStyle(variant: .info, delay: .short)
    private var viewProperties = SnackBarView.ViewProperties()
    private var variant: SnackBarViewStyle.Variant = .info
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createSnackBarSection(),
            createInputTitleTextSection(),
            createInputSubtitleTextSection(),
            createInputButtonTextSection(),
            createVariantSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createSnackBarSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<SnackBarView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.style.update(viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                self.snackBarView = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 142
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        
        return section
    }
    
    private func createInputTitleTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textField.text = self.viewProperties.title ?? .init(string: "")
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onTitleTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = SnackBarConstants.inputViewInsets
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitleText)
        
        return section
    }
    
    private func createInputSubtitleTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textField.text = self.viewProperties.subtitle ?? .init(string: "")
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onSubtitleTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = SnackBarConstants.inputViewInsets
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentSubtitleText)
        
        return section
    }
    
    private func createInputButtonTextSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<InputView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                var vp: InputView.ViewProperties = .init()
                vp.textField.text = self.viewProperties.bottomButton?.title ?? .init(string: "")
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onButtonTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = SnackBarConstants.inputViewInsets
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentButtonText)
        
        return section
    }
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Info", "Success", "Warning", "Error"],
            actions: [
                { [weak self] in self?.updateSnackBarViewStyle(variant: .info) },
                { [weak self] in self?.updateSnackBarViewStyle(variant: .success) },
                { [weak self] in self?.updateSnackBarViewStyle(variant: .warning) },
                { [weak self] in self?.updateSnackBarViewStyle(variant: .error) }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func updateSnackBarViewStyle(
        variant: SnackBarViewStyle.Variant
    ) {
        self.variant = variant
        style = .init(variant: self.variant, delay: .short)
        style.update(viewProperties: &viewProperties)
        snackBarView?.update(with: viewProperties)
    }
    
    @objc private func onTitleTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.title = nil
            return
        }
        
        viewProperties.title = .init(string: text)
        style.update(viewProperties: &viewProperties)
        snackBarView?.update(with: viewProperties)
    }
    
    @objc private func onSubtitleTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.subtitle = nil
            return
        }
        
        viewProperties.subtitle = .init(string: text)
        style.update(viewProperties: &viewProperties)
        snackBarView?.update(with: viewProperties)
    }
    
    @objc private func onButtonTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.bottomButton = nil
            return
        }
        
        viewProperties.bottomButton = .init(title: .init(string: text))
        style.update(viewProperties: &viewProperties)
        snackBarView?.update(with: viewProperties)
    }
}

// MARK: - Constants

private enum SnackBarConstants {
    static let inputViewInsets: UIEdgeInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
}
