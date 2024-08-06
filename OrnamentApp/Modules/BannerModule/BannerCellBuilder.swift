//
//  BannerCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 02.08.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class BannerCellBuilder: NSObject, UITextFieldDelegate, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var bannerView: BannerView?
    private var style = BannerViewStyle(variant: .neutral)
    private var viewProperties = BannerView.ViewProperties()
    private var variant: BannerViewStyle.Variant = .neutral
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createBannerSection(),
            createInputTitleTextSection(),
            createInputSubtitleTextSection(),
            createInputButtonTextSection(),
            createVariantSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createBannerSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<BannerView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.style.update(with: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                self.bannerView = cell.containedView
                
            },
            initializesFromNib: false
        )
        row.rowHeight = 88
        
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

                cell.contentInset = BannerConstants.inputViewInsets
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

                cell.contentInset = BannerConstants.inputViewInsets
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
                vp.textField.text = self.viewProperties.bottomButton?.text ?? .init(string: "")
                vp.textField.delegateAssigningClosure = { textField in
                    textField.delegate = self
                    textField.addTarget(self, action: #selector(self.onButtonTextChange(textField:)), for: .editingChanged)
                }
                let inputTextStyle = InputViewStyle()
                inputTextStyle.update(state: .default, viewProperties: &vp)
                cell.containedView.update(with: vp)

                cell.contentInset = BannerConstants.inputViewInsets
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
            titles: ["Neutral", "Warning", "Error", "Success"],
            actions: [
                { [weak self] in self?.updateBannerViewStyle(variant: .neutral) },
                { [weak self] in self?.updateBannerViewStyle(variant: .warning) },
                { [weak self] in self?.updateBannerViewStyle(variant: .error) },
                { [weak self] in self?.updateBannerViewStyle(variant: .success) }
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func updateBannerViewStyle(
        variant: BannerViewStyle.Variant
    ) {
        self.variant = variant
        style = .init(variant: self.variant)
        style.update(with: &viewProperties)
        bannerView?.update(with: viewProperties)
    }
    
    @objc private func onTitleTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.title = nil
            return
        }
        
        viewProperties.title = .init(string: text)
        style.update(with: &viewProperties)
        bannerView?.update(with: viewProperties)
    }
    
    @objc private func onSubtitleTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.subtitle = nil
            return
        }
        
        viewProperties.subtitle = .init(string: text)
        style.update(with: &viewProperties)
        bannerView?.update(with: viewProperties)
    }
    
    @objc private func onButtonTextChange(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            viewProperties.bottomButton = nil
            return
        }
        
        viewProperties.bottomButton = .init(text: .init(string: text))
        style.update(with: &viewProperties)
        bannerView?.update(with: viewProperties)
    }
}

// MARK: - Constants

private enum BannerConstants {
    static let inputViewInsets: UIEdgeInsets = .init(top: .zero, left: 16, bottom: .zero, right: 16)
}
