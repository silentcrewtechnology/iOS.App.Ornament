//
//  ComponentsShowcaseCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 03.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import SnapKit

struct ComponentsShowcaseCellBuilder {

    // MARK: - Methods
    
    func createSections(onClick: @escaping (Components) -> Void) -> [GenericTableViewSectionModel] {
        var rows = [TableViewRowModel]()
        
        for component in Components.allCases {
            rows.append(
                createTableComponentRow(
                    title: component.rawValue,
                    onClick: {
                        onClick(component)
                    }
                )
            )
        }
        
        let section = GenericTableViewSectionModel(with: rows)
        return [section]
    }
    
    // MARK: - Private methods
    
    private func createTableComponentRow(
        title: String,
        onClick: @escaping () -> Void
    ) -> TableViewRowModel {
        let row = GenericTableViewRowModel(
            with: TableComponentViewCell.self,
            configuration: { cell, _ in
                cell.update(with: .init(text: title))
            },
            andAction: { tableView, indexPath in
                tableView.deselectRow(at: indexPath, animated: true)
                onClick()
            },
            initializesFromNib: false
        )
        row.rowHeight = 52
        
        return row
    }
}
