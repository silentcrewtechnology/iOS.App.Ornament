//
//  ActivityIndicatorCellBuilder.swift
//  OrnamentApp
//
//  Created by user on 04.07.2024.
//

import UIKit
import ArchitectureTableView
import Extensions
import Components
import DesignSystem
import ImagesService
import SnapKit

final class ActivityIndicatorCellBuilder: CellBuilder {
    
    // MARK: - Private properties
    
    private var activityIndicator: ActivityIndicatorView?
    private let chipsViewSectionHelper = ChipsViewSectionHelper()

    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createActivityIndicatorSection(),
            createSizeSection(),
            createAnimatingSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createActivityIndicatorSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<ActivityIndicatorView>.self,
            configuration: { [weak self] cell, _ in
                cell.selectionStyle = .none
                cell.containedView.snp.remakeConstraints { make in
                    make.leading.equalToSuperview().inset(16)
                    make.size.equalTo(24)
                }
                
                self?.activityIndicator = cell.containedView
                self?.updateActivityIndicatorAnimating(isAnimating: true)
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: "Component.Title".localized)
        return section
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["24", "36", "48"],
            actions: [
                { [weak self] in self?.remakeActivityIndicatorSize(size: .init(width: 24, height: 24)) },
                { [weak self] in self?.remakeActivityIndicatorSize(size: .init(width: 36, height: 36)) },
                { [weak self] in self?.remakeActivityIndicatorSize(size: .init(width: 48, height: 48)) }
            ],
            headerTitle: "ActivityIndicator.Screen.Size.Title".localized
        )
    }
    
    private func createAnimatingSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSection(
            titles: ["Start", "Stop"],
            actions: [
                { [weak self] in self?.updateActivityIndicatorAnimating(isAnimating: true) },
                { [weak self] in self?.updateActivityIndicatorAnimating(isAnimating: false) }
            ],
            headerTitle: "ActivityIndicator.Screen.Animating.Title".localized,
            viewWidth: 62
        )
    }
    
    private func remakeActivityIndicatorSize(size: CGSize) {
        activityIndicator?.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(size)
        }
    }
    
    private func updateActivityIndicatorAnimating(isAnimating: Bool) {
        let viewProperties: ActivityIndicatorView.ViewProperties = .init(
            icon: .ic24SpinerLoader.withTintColor(.contentAction),
            size: .init(width: 24, height: 24),
            isAnimating: isAnimating
        )
        activityIndicator?.update(with: viewProperties)
    }
}
