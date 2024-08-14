//
//  BadgeModuleDataSource.swift
//  AbolArchitecture
//
//  Created by firdavs on 04.06.2024.
//
import DesignSystem
import Components
import Extensions
import Architecture
import UIKit

final class BadgeModuleDataSource: NSObject, UITableViewDataSource {
    
    private var rowsModels: [DSRowModel] = []
    private var sectionsCell: [Any] = []

    public func update(with rowsModels: [DSRowModel]) {
        self.rowsModels = rowsModels
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCell.isEmpty ? 1 : sectionsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = rowsModels[indexPath.row]
        
        let cell = DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: model.leading,
            center: model.center,
            trailing: model.trailing,
            centralBlockAlignment: model.centralBlockAlignment,
            cellSelectionStyle: .none)
        
        return cell
    }
}
