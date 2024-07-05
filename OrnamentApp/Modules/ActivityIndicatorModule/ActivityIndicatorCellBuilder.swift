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

final class ActivityIndicatorCellBuilder {
    
    // MARK: - Private properties
    
    private var activityIndicator: ActivityIndicatorView?
    private var sizeUpdaters: [ChipsViewUpdater] = []
    private var animatingUpdaters: [ChipsViewUpdater] = []

    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        sizeUpdaters = []
        
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
        makeHeader(in: section, title: "Component")
        return section
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<UIStackView>.self,
            configuration: { [weak self] cell, _ in
                let firstVP = ChipsView.ViewProperties(text: NSMutableAttributedString(string: "24"))
                let secondVP = ChipsView.ViewProperties(text: NSMutableAttributedString(string: "36"))
                let thirdVP = ChipsView.ViewProperties(text: NSMutableAttributedString(string: "48"))
                
                let firstChipsView = ChipsView()
                let secondChipsView = ChipsView()
                let thirdChipsView = ChipsView()
                cell.containedView.addArrangedSubview(firstChipsView)
                cell.containedView.addArrangedSubview(secondChipsView)
                cell.containedView.addArrangedSubview(thirdChipsView)
                
                self?.sizeUpdaters.append(
                    .init(
                        view: firstChipsView,
                        viewProperties: firstVP,
                        style: .init(
                            selection: .selected,
                            state: .default,
                            size: .small),
                        onActive: {
                            self?.sizeUpdaters[0].handle(state: .selection(.selected))
                            self?.sizeUpdaters[1].handle(state: .selection(.default))
                            self?.sizeUpdaters[2].handle(state: .selection(.default))
                            self?.remakeActivityIndicatorSize(size: .init(width: 24, height: 24))
                        },
                        onInactive: { })
                )
                self?.sizeUpdaters.append(
                    .init(
                        view: secondChipsView,
                        viewProperties: secondVP,
                        style: .init(
                            selection: .default,
                            state: .default,
                            size: .small),
                        onActive: {
                            self?.sizeUpdaters[0].handle(state: .selection(.default))
                            self?.sizeUpdaters[1].handle(state: .selection(.selected))
                            self?.sizeUpdaters[2].handle(state: .selection(.default))
                            self?.remakeActivityIndicatorSize(size: .init(width: 36, height: 36))
                        },
                        onInactive: { })
                )
                self?.sizeUpdaters.append(
                    .init(
                        view: thirdChipsView,
                        viewProperties: thirdVP,
                        style: .init(
                            selection: .default,
                            state: .default,
                            size: .small),
                        onActive: {
                            self?.sizeUpdaters[0].handle(state: .selection(.default))
                            self?.sizeUpdaters[1].handle(state: .selection(.default))
                            self?.sizeUpdaters[2].handle(state: .selection(.selected))
                            self?.remakeActivityIndicatorSize(size: .init(width: 48, height: 48))
                        },
                        onInactive: { })
                )
                
                let view = UIView()
                cell.containedView.addArrangedSubview(view)
                [firstChipsView, secondChipsView, thirdChipsView, view].forEach { chipsView in
                    chipsView.snp.makeConstraints { make in
                        make.width.equalTo(48)
                    }
                }
                
                cell.containedView.axis = .horizontal
                cell.containedView.spacing = 8
                cell.containedView.distribution = .fillProportionally
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 48
        
        let section = GenericTableViewSectionModel(with: [row])
        makeHeader(in: section, title: "ActivityIndicator.Screen.Size.Title".localized)
        return section
    }
    
    private func createAnimatingSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<UIStackView>.self,
            configuration: { [weak self] cell, _ in
                let firstVP = ChipsView.ViewProperties(text: NSMutableAttributedString(string: "Start"))
                let secondVP = ChipsView.ViewProperties(text: NSMutableAttributedString(string: "Stop"))
                
                let firstChipsView = ChipsView()
                let secondChipsView = ChipsView()
                cell.containedView.addArrangedSubview(firstChipsView)
                cell.containedView.addArrangedSubview(secondChipsView)
                
                self?.animatingUpdaters.append(
                    .init(
                        view: firstChipsView,
                        viewProperties: firstVP,
                        style: .init(
                            selection: .selected,
                            state: .default,
                            size: .small),
                        onActive: {
                            self?.animatingUpdaters[0].handle(state: .selection(.selected))
                            self?.animatingUpdaters[1].handle(state: .selection(.default))
                            self?.updateActivityIndicatorAnimating(isAnimating: true)
                        },
                        onInactive: { })
                )
                self?.animatingUpdaters.append(
                    .init(
                        view: secondChipsView,
                        viewProperties: secondVP,
                        style: .init(
                            selection: .default,
                            state: .default,
                            size: .small),
                        onActive: {
                            self?.animatingUpdaters[0].handle(state: .selection(.default))
                            self?.animatingUpdaters[1].handle(state: .selection(.selected))
                            self?.updateActivityIndicatorAnimating(isAnimating: false)
                        },
                        onInactive: { })
                )
                
                let view = UIView()
                cell.containedView.addArrangedSubview(view)
                [firstChipsView, secondChipsView, view].forEach { chipsView in
                    chipsView.snp.makeConstraints { make in
                        make.width.equalTo(62)
                    }
                }
                
                cell.containedView.axis = .horizontal
                cell.containedView.spacing = 8
                cell.containedView.distribution = .fillProportionally
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = 48
        
        let section = GenericTableViewSectionModel(with: [row])
        makeHeader(in: section, title:"ActivityIndicator.Screen.Animating.Title".localized)
        return section
    }
    
    private func makeHeader(
        in section: GenericTableViewSectionModel,
        title: String
    ) {
        section.headerProvider = { _, _ in
            let header = TableHeaderView()
            header.update(with: .init(text: title))
            
            return header
        }
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
