//
//  NavigationBarFeature.swift
//  OrnamentApp
//
//  Created by user on 26.07.2024.
//

import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import Components
import DesignSystem

final class NavigationBarFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: - Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: - Private properties
    
    private let cellBuilder = NavigationBarCellBuilder()
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var dataStorage = GenericTableViewDataStorage.empty
    
    // MARK: - Life cycle
    
    override init() {
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: dataStorage.tableViewDataSource,
            delegate: dataStorage.tableViewDelegate
        ))
        dataStorage.registerFor(tableViewBuilder.view)
        
        var navigationBarVP = NavigationBar.ViewProperties()
        let navigationBarStyle = NavigationBarStyle(
            variant: .none,
            color: .main
        )
        navigationBarStyle.update(viewProperties: &navigationBarVP)
        tableViewVCBuilder = .init(with: .init(
            navigationBarViewProperties: navigationBarVP,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))

        super.init()
    }
    
    // MARK: - Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        createSections()
        
        return tableViewVCBuilder
    }
    
    func setNavigationBar(navigationBar: NavigationBar?) {
        cellBuilder.setNavigationBar(navigationBar: navigationBar)
    }
    
    // MARK: - Private methods
    
    private func createSections() {
        let sections = cellBuilder.createSections()
        dataStorage.update(with: sections)
        dataStorage.registerFor(tableViewBuilder.view)
        
        tableViewBuilder.viewUpdater.state = .reloadData
    }
}

