//
//  ComponentsShowcaseFeature.swift
//  OrnamentApp
//
//  Created by user on 03.07.2024.
//

import UIKit
import Architecture
import ArchitectureTableView
import Extensions

final class ComponentsShowcaseFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: - Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: - Private properties
    
    private let cellBuilder = ComponentsShowcaseCellBuilder()
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

        tableViewVCBuilder = .init(with: .init(
            screenTitle: Constants.componentsShowcaseTitle,
            tableView: tableViewBuilder.view,
            confirmButtonView: nil
        ))
        tableViewVCBuilder.view.navigationItem.leftBarButtonItems = []

        super.init()
    }
    
    // MARK: - Methods
    
    func runFlow(data: Any?) -> (any Architecture.BuilderProtocol)? {
        createSections()
        
        return tableViewVCBuilder
    }
    
    // MARK: - Private methods
    
    private func createSections() {
        let sections = cellBuilder.createSections(onClick: handleComponentTapped)
        dataStorage.update(with: sections)
        dataStorage.registerFor(tableViewBuilder.view)
        
        tableViewBuilder.viewUpdater.state = .reloadData
    }
    
    private func handleComponentTapped(component: Components) {
        runNewFlow?(component)
    }
}
