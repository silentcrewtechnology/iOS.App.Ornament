//
//  BadgeModuleFeature.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 01.08.2024.
//

import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BadgeModuleFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: Private properties
    
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var navigationBarStyle: NavigationBarStyle
    
    private var tableDataSource: BadgeModuleDataSource
    private var tableDelegate: BadgeModuleTableDelegate
    
    private var badgeStyle: BadgeStyle
    private var badgeViewProperties: BadgeView.ViewProperties
    private let badgeImage: UIImage = .ic16Tick
    
    private var selectedColorIndex: Int = 0
    private var selectedSizeIndex: Int = 0
    private var selectedSetIndex: Int = 0
    
    init(
        screenTitle: String,
        backAction: (() -> Void)?
    ) {
        tableDataSource = BadgeModuleDataSource()
        tableDelegate = BadgeModuleTableDelegate()
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: tableDataSource,
            delegate: tableDelegate
        ))
        
        var navigationBarVP = NavigationBar.ViewProperties()
        navigationBarStyle = NavigationBarStyle(
            variant: .basic(
                title: screenTitle,
                subtitle: nil,
                margins: nil
            ),
            color: .primary
        )
        navigationBarStyle.update(viewProperties: &navigationBarVP, backAction: backAction)
        
        tableViewVCBuilder = .init(with: .init(
            navigationBarViewProperties: navigationBarVP,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))
        
        badgeStyle = BadgeStyle(color: .neutral, size: .large, set: .full)
        badgeViewProperties = BadgeView.ViewProperties(text: "23 +".attributed, image: .ic16Tick)
        
        super.init()
    }
    
    // MARK: Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        setCell()
        return tableViewVCBuilder
    }
    
    // MARK: Private methods
    
    private func setCell() {
        let cells: [DSRowModel] = [
            createBadgeRow(),
            createColorRow(),
            createSizeRow(),
            createSetRow()
        ]
        tableDataSource.update(with: cells)
    }
}

// MARK: Create Rows

extension BadgeModuleFeature {
    
    private func createBadgeRow() -> DSRowModel {
        return DSRowModel(leading: .atom(.badgeView(badgeViewProperties, badgeStyle)))
    }
    
    // TODO: Добавить InputView в атомы
    //    private func createInputTextRow() -> DSRowModel {
    //
    //    }
    
    private func createColorRow() -> DSRowModel {
        let chipTitles = ["neutral", "accent", "accentBrand", "accentInfo"]
        let chipColors: [BadgeStyle.Color] = [.neutral, .accent, .accentBrand, .accentInfo]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView.ViewProperties, ChipsViewStyle) in
            let chipsStyle = ChipsViewStyle()
            let isSelected = selectedColorIndex == index
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                isSelected: isSelected,
                onChipsTap: { [weak self] _ in
                    self?.selectedColorIndex = index
                    self?.updateStyle(newColor: chipColors[index])
                })
            return (chipsViewProperties, chipsStyle)
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipses(chips)))
    }
    
    private func createSizeRow() -> DSRowModel {
        let chipTitles = ["large", "small"]
        let chipSizes: [BadgeStyle.Size] = [.large, .small]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView.ViewProperties, ChipsViewStyle) in
            let chipsStyle = ChipsViewStyle()
            let isSelected = selectedSizeIndex == index
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                isSelected: isSelected,
                onChipsTap: { [weak self] _ in
                    self?.selectedSizeIndex = index
                    self?.updateStyle(newSize: chipSizes[index])
                })
            return (chipsViewProperties, chipsStyle)
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipses(chips)))
    }
    
    private func createSetRow() -> DSRowModel {
        let chipTitles = ["full", "basic", "simple"]
        let chipSets: [BadgeStyle.Set] = [.full, .basic, .simple]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView.ViewProperties, ChipsViewStyle) in
            let chipsStyle = ChipsViewStyle()
            let isSelected = selectedSetIndex == index
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                isSelected: isSelected,
                onChipsTap: { [weak self] _ in
                    self?.selectedSetIndex = index
                    self?.updateStyle(newSet: chipSets[index])
                })
            return (chipsViewProperties, chipsStyle)
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipses(chips)))
    }
}

// MARK: Update Badge

extension BadgeModuleFeature {
    
    private func updateStyle(
        newColor: BadgeStyle.Color? = nil,
        newSize: BadgeStyle.Size? = nil,
        newSet: BadgeStyle.Set? = nil
    ) {
        badgeViewProperties.text = "99+".attributed
        badgeViewProperties.image = badgeImage
        badgeStyle.update(
            newColor: newColor,
            newSize: newSize,
            newSet: newSet,
            viewProperties: &badgeViewProperties)
        
        // TODO: конфликты в констрейнтах при обновлении ячееек с чипсами
        // TODO: Сделать обновление так, чтобы ячейка с chips не скролилась в начало
        setCell()
        tableViewBuilder.viewUpdater.state = .reloadData
    }
}
