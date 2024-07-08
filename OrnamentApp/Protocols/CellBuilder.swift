//
//  CellBuilder.swift
//  OrnamentApp
//
//  Created by user on 08.07.2024.
//

import Foundation
import ArchitectureTableView

protocol CellBuilder {
    func createSections() -> [GenericTableViewSectionModel]
}
