//
//  GibddFineCellsExample.swift
//
//
//  Created by user on 30.05.2024.
//

import UIKit
import Foundation
import DesignSystem

private final class GibddFineCellsExampleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private var tableView = UITableView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return create1GibddRow(tableView, indexPath: indexPath)
        case 1:
            return create2GibddRow(tableView, indexPath: indexPath)
        case 2:
            return create3GibddRow(tableView, indexPath: indexPath)
        case 3:
            return create4GibddRow(tableView, indexPath: indexPath)
        case 4:
            return create5GibddRow(tableView, indexPath: indexPath)
        case 5:
            return create6GibddRow(tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - Private methods
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    private func create1GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .disabled,
            icon: .without
        )
        let labelStyle = LabelViewStyle(variant: .rowSubtitle, alignment: .center)
        let onTap: () -> Void = { }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitles(("АО «Татэнергосбыт»", nil), [("За апрель", nil), ("Автоплатеж подключен", nil)])),
            trailing: .molecule(
                .buttonWithSubindex(
                    ("4 158,40 ₽", onTap, buttonStyle),
                    ("Оплачено", labelStyle)
                )
            )
        )
    }
    
    private func create2GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .disabled,
            icon: .without
        )
        let labelStyle = LabelViewStyle(variant: .subindex, alignment: .center)
        let onTap: () -> Void = { }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitle(("АО «Татэнергосбыт»", nil), ("За апрель", nil))),
            trailing: .molecule(
                .buttonWithSubindex(
                    ("4 158,40 ₽", onTap, buttonStyle),
                    ("Оплачено", labelStyle)
                )
            )
        )
    }
    
    private func create3GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .disabled,
            icon: .without
        )
        let labelStyle = LabelViewStyle(variant: .subindex, alignment: .center)
        let onTap: () -> Void = { }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitle(("АО «Татэнергосбыт»", nil), ("За апрель", nil))),
            trailing: .molecule(
                .buttonWithSubindex(
                    ("150 ₽", onTap, buttonStyle),
                    ("Оплачено", labelStyle)
                )
            )
        )
    }
    
    private func create4GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .disabled,
            icon: .without
        )
        let onTap: () -> Void = {
            print("Tapped 4 row!")
        }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitle(("Штраф от 21.05", nil), ("Скидка до 21.09", nil))),
            center: .atom(.index("3 000 ₽", nil)),
            trailing: .atom(.button("1 500 ₽", onTap, buttonStyle))
        )
    }
    
    private func create5GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .default,
            icon: .without
        )
        let onTap: () -> Void = {
            print("Tapped 5 row!")
        }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitles(("АО «Татэнергосбыт»", nil), [("За март", nil), ("Автоплатеж подключен", nil)])),
            trailing: .atom(.button("308,52 ₽", onTap, buttonStyle))
        )
    }
    
    private func create6GibddRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let buttonStyle = ButtonViewStyle(
            size: .small,
            color: .accent,
            variant: .primary,
            state: .default,
            icon: .without
        )
        let onTap: () -> Void = {
            print("Tapped 6 row!")
        }
        
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .molecule(
                .titleWithSubtitle(("РО Капитального ремонта", nil), ("За март", nil))),
            trailing: .atom(.button("308,52 ₽", onTap, buttonStyle))
        )
    }
}
