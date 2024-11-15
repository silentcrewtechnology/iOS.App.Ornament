//
//  TitleCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 29.07.2024.
//

import UIKit
import ArchitectureTableView
import Components
import DesignSystem
import ImagesService
import Extensions

final class TitleCellBuilder: CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private lazy var titleViewService: TitleViewService = .init(
        viewProperties: .init(
            title: titleText.attributed,
            description: descriptionText.attributed
        ),
        style: .init(size: .extraLarge, color: .primary),
        buttonIconService: .init(
            viewProperties: .init(
                image: .ic16Close,
                onTap: { print("Tapped") }
            ),
            style: .init(variant: .secondary, size: .small, state: .default, color: .accent))
    )
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createViewSection(),
            createTitleLengthSection(),
            createColorSection(),
            createDescriptionLengthSection(),
            createSizeSection(),
            createButtonVisibilitySection(),
        ]
    }
    
    // MARK: - Private methods
    
    private func createViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: UITableViewCell.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                cell.contentView.subviews.forEach { $0.removeFromSuperview() }
                cell.contentView.addSubview(titleViewService.view)
                cell.selectionStyle = .none
                titleViewService.view.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                        .inset(UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
                }
                updateTitleViewStyle()
            },
            initializesFromNib: false
        )
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        
        return section
    }
    
    private lazy var titleText: String = longTitle
    private let shortTitle = "Title"
    private let longTitle = String(repeating: "T ", count: 40)
    
    private func createTitleLengthSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Long", "Short", "Hide"],
            actions: [
                { [weak self] in guard let self else { return }
                    titleText = longTitle
                    updateTitleViewStyle(newTitle: titleText.attributed)
                },
                { [weak self] in guard let self else { return }
                    titleText = shortTitle
                    updateTitleViewStyle(newTitle: titleText.attributed)
                },
                { [weak self] in guard let self else { return }
                    updateTitleViewStyle(newTitle: "".attributed)
                },
            ],
            headerTitle: "Title length"
        )
    }
    
    private lazy var descriptionText: String = longDescription
    private let shortDescription = "Description"
    private let longDescription = String(repeating: "D ", count: 80)
    
    private func createDescriptionLengthSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Long", "Short", "Hide"],
            actions: [
                { [weak self] in guard let self else { return }
                    updateTitleViewStyle(newDescription: longDescription.attributed)
                },
                { [weak self] in guard let self else { return }
                    updateTitleViewStyle(newDescription: shortDescription.attributed)
                },
                { [weak self] in guard let self else { return }
                    updateTitleViewStyle(newDescription: "".attributed)
                },
            ],
            headerTitle: "Description length"
        )
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Extra large", "Large", "Medium", "Small"],
            actions: [
                { [weak self] in self?.updateTitleViewStyle(newSize: .extraLarge) },
                { [weak self] in self?.updateTitleViewStyle(newSize: .large) },
                { [weak self] in self?.updateTitleViewStyle(newSize: .medium) },
                { [weak self] in self?.updateTitleViewStyle(newSize: .small) },
            ],
            headerTitle: Constants.componentSize
        )
    }
    
    private func createColorSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Primary", "Secondary"],
            actions: [
                { [weak self] in self?.updateTitleViewStyle(newTitleColor: .primary) },
                { [weak self] in self?.updateTitleViewStyle(newTitleColor: .secondary) }
            ],
            headerTitle: "Title color"
        )
    }
    
    private func createButtonVisibilitySection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Show", "Hide"],
            actions: [
                { [weak self] in guard let self else { return } ; updateTitleViewStyle(showButton: true) },
                { [weak self] in guard let self else { return } ; updateTitleViewStyle(showButton: false) },
            ],
            headerTitle: "Button visibility"
        )
    }
    
    private func updateTitleViewStyle(
        newSize: TitleViewStyle.Size? = nil,
        newTitle: NSMutableAttributedString? = nil,
        newTitleColor: TitleViewStyle.Color? = nil,
        newDescription: NSMutableAttributedString? = nil,
        showButton: Bool? = nil
    ) {
        tableView?.beginUpdates()
        titleViewService.update(
            newSize: newSize,
            newTitle: newTitle,
            newTitleColor: newTitleColor,
            newDescription: newDescription,
            showButton: showButton
        )
        tableView?.endUpdates()
    }
    
    /// Ищем `tableView`, чтобы обновить `cell.heightConstraint`
    private var tableView: UITableView? {
        var view: UIView? = titleViewService.view
        while view != nil {
            view = view?.superview
            switch view {
            case let view as UITableView: return view
            default: continue
            }
        }
        return nil
    }
}
