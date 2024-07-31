//
//  TileModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 30.07.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class TileModuleBuilder: NSObject, CellBuilder {
    
    private var tileView: TileView?
    private var style = TileViewStyle(background: .primary, widthType: .s)
    private var viewProperties = TileView.ViewProperties(text: "Пример Пример".attributed)
    
    private var imageStyle = ImageViewStyle(type: .icon(.ic24UserFilled),
                                            color: .main)
    private var imageViewProperties = ImageView.ViewProperties()

    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    private var newBackground: TileViewStyle.Background?
    private var newWidthType: TileViewStyle.WidthType?
    private var newImageType: ImageViewStyle.Types?
    private var newImageColor: ImageViewStyle.Color?
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createTileViewSection(),
            createWidthTypeSection(),
            createBackgroundSection(),
            createImageTypeSection(),
            createColorSection()
        ]
    }
}

// MARK: TileView
extension TileModuleBuilder {
    private func createTileViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<TileView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                self.tileView = cell.containedView
                
                newBackground = .primary
                newImageType = .icon(.ic24UserFilled)
                newImageColor = .main

                self.imageStyle.update(
                    type: newImageType,
                    color: newImageColor,
                    viewProperties: &self.imageViewProperties
                )
                
                viewProperties.imageViewProperties = imageViewProperties
                
                self.style.update(background: newBackground,
                                  viewProperties: &self.viewProperties)
                
                self.tileView?.update(with: self.viewProperties)
                cell.selectionStyle = .none
                
                self.tileView?.snp.remakeConstraints{
                    $0.top.equalToSuperview()
                    $0.leading.equalToSuperview().offset(16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 144
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
}

// MARK: Styles
extension TileModuleBuilder {
    private func createBackgroundSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["primary", "main"],
            actions: [
                { [weak self] in
                    self?.newBackground = .primary
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newBackground = .main
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.componentBackground
        )
    }
    
    private func createWidthTypeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["s", "m"],
            actions: [
                { [weak self] in
                    self?.newWidthType = .s
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newWidthType = .m
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.componentType
        )
    }
    
    private func createImageTypeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["icon", "letter", "fillImage", "custom"],
            actions: [
                { [weak self] in
                    self?.newImageType = .icon(.ic24UserFilled)
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageType = .letter("AA".attributed)
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageType = .fillImage(.init(resource: .imageViewFill))
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageType = .custom(.ic16BoxFilled, .init(width: 24, height: 24))
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.imageType
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
                    self?.newImageColor = .primary
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .main
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .mainInverse
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional1
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional2
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional3
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional4
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional5
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional6
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional7
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newImageColor = .additional8
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.imageColor
        )
    }
    
    private func updateStyle() {
        style.update(
            background: newBackground,
            widthType: newWidthType,
            viewProperties: &viewProperties)
        
        imageStyle.update(
            type: newImageType,
            color: newImageColor,
            viewProperties: &imageViewProperties)
        
        viewProperties.imageViewProperties = imageViewProperties
        
        tileView?.update(with: viewProperties)
    }
}
