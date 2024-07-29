//
//  ImageModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 24.07.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class ImageModuleBuilder: NSObject, CellBuilder {
    
    private var imageView: ImageView?
    private var style = ImageViewStyle(type: .icon(.ic24UserFilled),
                                       color: .primary)
    private var viewProperties = ImageView.ViewProperties()
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createImageViewSection(),
            createTypeSection(),
            createColorSection()
        ]
    }
}

// MARK: ImageView
extension ImageModuleBuilder {
    private func createImageViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ImageView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                self.style.update(type: .icon(.ic24UserFilled),
                                  color: .primary,
                                  viewProperties: &self.viewProperties)
                cell.containedView.update(with: self.viewProperties)
                cell.selectionStyle = .none
                self.imageView = cell.containedView
                
                cell.containedView.snp.remakeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().offset(16)
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

// MARK: Styles
extension ImageModuleBuilder {
    private func createTypeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["icon", "letter", "fillImage", "custom"],
            actions: [
                { [weak self] in
                    self?.updateStyle(newType: .icon(.ic24UserFilled))
                },
                { [weak self] in
                    self?.updateStyle(newType: .letter("AA".attributed))
                },
                { [weak self] in
                    self?.updateStyle(newType: .fillImage(.init(resource: .imageViewFill)))
                },
                { [weak self] in
                    self?.updateStyle(newType: .custom(.ic16BoxFilled, .init(width: 24, height: 24)))
                }
            ],
            headerTitle: Constants.componentType
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["primary",
                     "main",
                     "mainInverse",
                     "additional1",
                     "additional2",
                     "additional3",
                     "additional4",
                     "additional5",
                     "additional6",
                     "additional7",
                     "additional8"
                    ],
            actions: [
                { [weak self] in
                    self?.updateStyle(newColor: .primary)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .main)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .mainInverse)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional1)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional2)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional3)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional4)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional5)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional6)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional7)
                },
                { [weak self] in
                    self?.updateStyle(newColor: .additional8)
                }
            ],
            headerTitle: Constants.componentType
        )
    }
    
    private func updateStyle(
        newType: ImageViewStyle.Types? = nil,
        newColor: ImageViewStyle.Color? = nil
    ) {
        style.update(
            type: newType,
            color: newColor,
            viewProperties: &viewProperties)
        imageView?.update(with: viewProperties)
        imageView?.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
