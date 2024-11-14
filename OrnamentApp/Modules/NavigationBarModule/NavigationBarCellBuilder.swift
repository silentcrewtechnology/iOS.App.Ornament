//
//  NavigationBarCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 26.07.2024.
//

import UIKit
import ImagesService
import DesignSystem
import Components
import ArchitectureTableView

final class NavigationBarCellBuilder: NSObject, UITextFieldDelegate, UISearchResultsUpdating, CellBuilder {

    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var navigationBar: NavigationBar?
    private var viewProperties = NavigationBar.ViewProperties()
    private var style = NavigationBarStyle(variant: .none, color: .main)
    private var variant: NavigationBarStyle.Variant = .none
    private var color: NavigationBarStyle.Color = .main

    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createVariantSection(),
            createColorSection(),
            createRightItemsSection()
        ]
    }
    
    func setNavigationBar(navigationBar: NavigationBar?) {
        self.navigationBar = navigationBar
        
        updateNavigationBarStyle()
    }
    
    func updateSearchResults(for searchController: UISearchController) { }
    
    // MARK: - Private methods
    
    private func createVariantSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["None", "Basic", "Collapsed", "Main screen", "Basic amount", "Search"],
            actions: [
                { [weak self] in self?.updateNavigationBarStyle(variant: NavigationBarStyle.Variant.none) },
                { [weak self] in self?.updateNavigationBarStyle(variant: .basic(title: "Title", subtitle: "Subtitle", margins: nil)) },
                { [weak self] in self?.updateNavigationBarStyle(variant: .collapsed(title: "Title")) },
                { [weak self] in self?.updateNavigationBarStyle(variant: .mainScreen(name: "Name", icon: .ic24UserFilled.centered(in: .circle(backgroundColor: .clear, diameter: 40)), margins: nil, onProfile: { })) },
                { [weak self] in self?.updateNavigationBarStyle(variant: .basicAmount(title: "Title", subtitle: "Subtitle", spacing: nil, updateAction: { print("Update tapped") }))
                },
                { [weak self] in self?.updateNavigationBarStyle(variant: .search(title: "Title", subtitle: "Subtitle", margins: nil, onTextDidChange: nil, cancelButtonClicked: nil, textDidBeginEditing: nil, textDidEndEditing: nil)) },
            ],
            headerTitle: Constants.componentVariant
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Main", "Primary"],
            actions: [
                { [weak self] in self?.updateNavigationBarStyle(color: .main) },
                { [weak self] in self?.updateNavigationBarStyle(color: .primary) }
            ],
            headerTitle: Constants.componentColor
        )
    }
    
    private func createRightItemsSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["0", "1", "2", "3"],
            actions: [
                { [weak self] in self?.createRightItems(amount: .zero) },
                { [weak self] in self?.createRightItems(amount: 1) },
                { [weak self] in self?.createRightItems(amount: 2) },
                { [weak self] in self?.createRightItems(amount: 3) },
            ],
            headerTitle: Constants.componentRightItemsAmount
        )
    }
    
    private func updateNavigationBarStyle(
        variant: NavigationBarStyle.Variant? = nil,
        color: NavigationBarStyle.Color? = nil
    ) {
        if let variant {
            self.variant = variant
        }
        
        if let color {
            self.color = color
        }
        
        viewProperties = .init()
        style = .init(variant: self.variant, color: self.color)
        style.update(viewProperties: &viewProperties) { [weak self] in
            self?.navigationBar?.popToRootViewController(animated: true)
        }
        navigationBar?.update(with: viewProperties)
    }
    
    private func createRightItems(amount: Int) {
        var items = [UIBarButtonItem]()
        
        for _ in 0..<amount {
            items.append(.init(
                image: .ic24Frame
                    .withTintColor(.Core.Brand.neutral900)
                    .withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: nil,
                action: nil
            ))
        }
        
        viewProperties.rightBarButtonItems = items
        navigationBar?.update(with: viewProperties)
    }
}
