//
//  RowCellExampleVC.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import SnapKit
import Components
import DesignSystem

private final class RowCellExampleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private properties

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14 // Количество строк, которые вы хотите отобразить
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return createTitleRow(tableView, indexPath: indexPath)
        case 1:
            return createImageWithTitleRow(tableView, indexPath: indexPath)
        case 2:
            return createImageWithTitleSubtitleRow(tableView, indexPath: indexPath)
        case 3:
            return createImageWithButtonRow(tableView, indexPath: indexPath)
        case 4:
            return createImageWithToggleRow(tableView, indexPath: indexPath)
        case 5:
            return createImageWithCheckboxRow(tableView, indexPath: indexPath)
        case 6:
            return createImageWithIndexRow(tableView, indexPath: indexPath)
        case 7:
            return createImageWithIndexIcons20Row(tableView, indexPath: indexPath)
        case 8:
            return createCardWithTitleButtonRow(tableView, indexPath: indexPath)
        case 9:
            return createLongTitleRow(tableView, indexPath: indexPath)
        case 10:
            return createImageLongTextWithButtonRow(tableView, indexPath: indexPath)
        case 11:
            return createImageWithLongTitleSubtitleRow(tableView, indexPath: indexPath)
        case 12:
            return createImageLongTextWithRadioRow(tableView, indexPath: indexPath)
        case 13:
            return createImageWithLongTitleRow(tableView, indexPath: indexPath)
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
    }
    
    private func createTitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let titleStyle = LabelViewStyle(variant: .rowTitle(recognizer: nil))
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.title("Title", titleStyle, nil))
        )
    }
    
    private func createImageWithTitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .atom(.title("Title", nil, nil))
        )
    }
    
    private func createImageWithTitleSubtitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.titleWithSubtitle(("Title", nil, nil), ("Subtitle", nil)))
        )
    }
    
    private func createImageWithButtonRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    private func createImageWithToggleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.toggle(true, { _ in }, nil))
        )
    }
    
    private func createImageWithCheckboxRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .atom(.checkbox(true, { _ in }, nil))
        )
    }
    
    private func createImageWithIndexRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .molecule(.indexWithIcon24(("Index", nil), (.ic24ChevronSmallRight, nil)))
        )
    }
    
    private func createImageWithIndexIcons20Row(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Subtitle", nil), ("Title", nil, nil))),
            trailing: .molecule(.indexWithIcons20(("Index", nil), [(.ic24BoxFilled, nil), (.ic24BoxFilled, nil)]))
        )
    }
    
    private func createCardWithTitleButtonRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.card(.ic24CardMirLight, nil)),
            center: .atom(.title("Title", nil, nil)),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    // примеры с текстом на несколько строк
    private func createLongTitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let titleStyle = LabelViewStyle(variant: .rowTitle(recognizer: nil))
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.title("Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст.", titleStyle, nil))
        )
    }
    
    private func createImageLongTextWithButtonRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст.", nil), ("Title", nil, nil))),
            trailing: .atom(.button("Label", { }, nil))
        )
    }
    
    private func createImageLongTextWithRadioRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст.", nil), ("Title", nil, nil))),
            trailing: .atom(.radio(true, { }, nil))
        )
    }
    
    private func createImageWithLongTitleSubtitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            center: .molecule(.subtitleWithTitle(("Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст.", nil), ("Title", nil, nil)))
        )
    }
    
    private func createImageWithLongTitleRow(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return DSCreationRowsViewService().createCellRowWithBlocks(
            tableView: tableView,
            indexPath: indexPath,
            leading: .atom(.image40(.ic24UserFilled, nil)),
            trailing: .atom(.title("Передаем для тестирования очень длинный текст. Передаем для тестирования очень длинный текст.", nil, nil))
        )
    }
}
