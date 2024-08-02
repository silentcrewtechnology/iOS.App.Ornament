//
//  StepperModuleBuilder.swift
//  OrnamentApp
//
//  Created by Омельченко Юлия on 02.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView

final class StepperModuleBuilder: NSObject, CellBuilder {
    
    private var stepperView: StepperView?
    private var viewProperties = StepperView.ViewProperties()
    private var itemsViewProperties: [StepperItemView.ViewProperties] = []
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    
    private var newAllCount = 8
    private var newActiveCount = 6
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createStepperViewSection(),
            createAllItemCountSection(),
            createActiveItemCountSection()
        ]
    }
}

// MARK: StepperView
extension StepperModuleBuilder {
    private func createStepperViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<StepperView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
                
                for index in (0..<newAllCount) {
                    let vp = createItemViewProperty(activeCount: newActiveCount,
                                                    index: index)
                    itemsViewProperties.append(vp)
                }
                
                self.stepperView = cell.containedView
                
                self.viewProperties = StepperView.ViewProperties(items: itemsViewProperties,
                                                                 height: 4)
                stepperView?.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                
                cell.containedView.snp.remakeConstraints {
                    $0.top.equalToSuperview().offset(16)
                    $0.leading.equalToSuperview().offset(16)
                    $0.trailing.equalToSuperview().offset(-16)
                }
            },
            initializesFromNib: false
        )
        row.rowHeight = 72
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        return section
    }
    
    private func createItemViewProperty(
        activeCount: Int,
        index: Int
    ) -> StepperItemView.ViewProperties {
        
        var itemViewProperties = StepperItemView.ViewProperties()
        let itemStyle = StepperItemViewStyle()
        let itemState: StepperItemViewStyle.State
        
        if index < activeCount {
            itemState = .success
        } else if index == activeCount {
            itemState = .current
        } else {
            itemState = .next
        }
        
        itemStyle.update(state: itemState,
                         viewProperties: &itemViewProperties)
        return itemViewProperties
    }
}

// MARK: Styles
extension StepperModuleBuilder {
    private func createAllItemCountSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["8", "7", "6", "5", "4", "3"],
            actions: [
                { [weak self] in
                    self?.newAllCount = 8
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newAllCount = 7
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newAllCount = 6
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newAllCount = 5
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newAllCount = 4
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newAllCount = 3
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.allCount
        )
    }
    
    private func createActiveItemCountSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["6", "5", "4", "3", "2", "1", "0"],
            actions: [
                { [weak self] in
                    self?.newActiveCount = 6
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 5
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 4
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 3
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 2
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 1
                    self?.updateStyle()
                },
                { [weak self] in
                    self?.newActiveCount = 0
                    self?.updateStyle()
                }
            ],
            headerTitle: Constants.activeCount
        )
    }
    
    private func updateStyle() {
        itemsViewProperties = []
        
        for index in (0..<newAllCount) {
            let vp = createItemViewProperty(activeCount: newActiveCount,
                                            index: index)
            itemsViewProperties.append(vp)
        }
        
        viewProperties.items = itemsViewProperties
        stepperView?.update(with: viewProperties)
    }
}
