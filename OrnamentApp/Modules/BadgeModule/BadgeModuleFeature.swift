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
    
    private var badgeUpdater: BadgeViewService
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var setChipsUpdaters: [ChipsViewService] = []
    
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
        
        // MARK: Badge
        let badgeStyle = BadgeStyle(color: .neutral, size: .large, set: .full)
        let badgeViewProperties = BadgeView.ViewProperties(text: "23 +".attributed, image: .ic16Tick)
        
        badgeUpdater = BadgeViewService(
            viewProperties: badgeViewProperties,
            style: badgeStyle
        )
        
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
        return DSRowModel(leading: .atom(.view(badgeUpdater.view)))
    }
    
    private func createColorRow() -> DSRowModel {
        colorChipsUpdaters = []
        let chipTitles = ["neutral", "accent", "accentBrand", "accentInfo"]
        let chipColors: [BadgeStyle.Color] = [.neutral, .accent, .accentBrand, .accentInfo]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView) in
            let isSelected = selectedColorIndex == index
            
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                onChipsTap: { [weak self] _ in
                    guard let self else { return }
                    badgeUpdater.update(newColor: chipColors[index])
                    for (i, updater) in colorChipsUpdaters.enumerated() {
                        let selected: ChipsViewStyle.Selected = index == i ? .on : .off
                        updater.update(selected: selected)
                    }
                })
            
            let selected: ChipsViewStyle.Selected = isSelected ? .on :.off
            let chipsStyle = ChipsViewStyle(selected: selected)
            
            let chipsUpdater = ChipsViewService(
                viewProperties: chipsViewProperties,
                style: chipsStyle
            )
            colorChipsUpdaters.append(chipsUpdater)
            
            return chipsUpdater.view
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipseViews(chips)))
    }
    
    private func createSizeRow() -> DSRowModel {
        sizeChipsUpdaters = []
        let chipTitles = ["large", "small"]
        let chipSizes: [BadgeStyle.Size] = [.large, .small]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView) in
            let isSelected = selectedSizeIndex == index
            
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                onChipsTap: { [weak self] _ in
                    guard let self else { return }
                    badgeUpdater.update(newSize: chipSizes[index])
                    
                    for (i, updater) in sizeChipsUpdaters.enumerated() {
                        let selected: ChipsViewStyle.Selected = index == i ? .on : .off
                        updater.update(selected: selected)
                    }
                })
            
            let selected: ChipsViewStyle.Selected = isSelected ? .on :.off
            let chipsStyle = ChipsViewStyle(selected: selected)
            
            let chipsUpdater = ChipsViewService(
                viewProperties: chipsViewProperties,
                style: chipsStyle
            )
            sizeChipsUpdaters.append(chipsUpdater)
            
            return chipsUpdater.view
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipseViews(chips)))
    }
    
    private func createSetRow() -> DSRowModel {
        setChipsUpdaters = []
        let chipTitles = ["full", "basic", "simple"]
        let chipSets: [BadgeStyle.Set] = [.full, .basic, .simple]
        
        let chips = chipTitles.enumerated().map { (index, title) -> (ChipsView) in
            let isSelected = selectedSizeIndex == index
            
            let chipsViewProperties = ChipsView.ViewProperties(
                text: .init(string: title),
                onChipsTap: { [weak self] _ in
                    guard let self else { return }
                    badgeUpdater.update(newSet: chipSets[index])
                    
                    for (i, updater) in setChipsUpdaters.enumerated() {
                        let selected: ChipsViewStyle.Selected = index == i ? .on : .off
                        updater.update(selected: selected)
                    }
                })
            
            let selected: ChipsViewStyle.Selected = isSelected ? .on :.off
            let chipsStyle = ChipsViewStyle(selected: selected)
            
            let chipsUpdater = ChipsViewService(
                viewProperties: chipsViewProperties,
                style: chipsStyle
            )
            setChipsUpdaters.append(chipsUpdater)
            
            return chipsUpdater.view
        }
        
        return DSRowModel(leading: .molecule(.horizontalChipseViews(chips)))
    }
}
