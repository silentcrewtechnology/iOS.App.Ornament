//
//  GenericTableViewSectionModel+Extensions.swift
//  OrnamentApp
//
//  Created by user on 05.07.2024.
//

import ArchitectureTableView

extension GenericTableViewSectionModel {
    func makeHeader(
        title: String
    ) {
        self.headerProvider = { _, _ in
            let header = TableHeaderView()
            header.update(with: .init(text: title))
            
            return header
        }
    }
}
