//
//  CommonDetailFeature.swift
//  OrnamentApp
//
//  Created by user on 08.07.2024.
//

import UIKit
import Architecture
import ArchitectureTableView
import Extensions

final class CommonDetailFeature: NSObject, FeatureCoordinatorProtocol {
    
    // MARK: - Properties
    
    var runNewFlow: ((Any) -> Void)?
    
    // MARK: - Private properties
    
    private let cellBuilder: CellBuilder
    private var tableViewVCBuilder: TableViewVCBuilder
    private var tableViewBuilder: TableViewBuilder
    private var dataStorage = GenericTableViewDataStorage.empty
    
    // MARK: - Life cycle
    
    init(
        cellBuilder: CellBuilder,
        screenTitle: String
    ) {
        self.cellBuilder = cellBuilder
        
        tableViewBuilder = .init(with: .init(
            backgroundColor: .white,
            dataSources: dataStorage.tableViewDataSource,
            delegate: dataStorage.tableViewDelegate
        ))
        dataStorage.registerFor(tableViewBuilder.view)

        tableViewVCBuilder = .init(with: .init(
            screenTitle: screenTitle,
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
    
    // MARK: - Private methods
    
    private func createSections() {
        let sections = cellBuilder.createSections()
        dataStorage.update(with: sections)
        dataStorage.registerFor(tableViewBuilder.view)
        
        tableViewBuilder.viewUpdater.state = .reloadData
    }
}
