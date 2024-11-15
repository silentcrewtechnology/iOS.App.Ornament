//
//  ChipsViewSectionHelper.swift
//  OrnamentApp
//
//  Created by user on 08.07.2024.
//

import UIKit
import ArchitectureTableView
import Extensions
import Components
import DesignSystem
import SnapKit

struct ChipsViewSectionHelper { 
    
    @available(*, deprecated, message: "Use feature + viewService")
    func makeHorizontalSectionWithScroll(
        titles: [String],
        actions: [() -> Void],
        headerTitle: String,
        rowHeight: CGFloat = 48
    ) -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<UIScrollView>.self,
            configuration: { cell, _ in
                var chipsServices = [ChipsViewService]()
                var views = [UIView]()
                let stackView = UIStackView()
                cell.containedView.addSubview(stackView)
                stackView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                for i in 0..<titles.count {
                    let chipsViewProperties = ChipsView.ViewProperties(
                        text: titles[i].attributed,
                        onChipsTap: { _ in
                            for j in 0..<chipsServices.count {
                                if j == i {
                                    chipsServices[j].update(selected: .on)
                                    continue
                                }
                                
                                chipsServices[j].update(selected: .off)
                            }
                            
                            actions[i]()
                        }
                    )
                    
                    let chipsView = ChipsView()
                    stackView.addArrangedSubview(chipsView)
                    views.append(chipsView)
                    
                    
                    let chipsStyle = ChipsViewStyle(
                        set: .leftIcon,
                        size: .large,
                        state: .default,
                        selected: i == 0 ? .on : .off,
                        label: .true,
                        icon: .false)
                    
                    let chipsService = ChipsViewService(
                        view: chipsView,
                        viewProperties: chipsViewProperties,
                        style: chipsStyle,
                        isSelected: false)
                    
                    chipsServices.append(chipsService)
                }
                
                stackView.axis = .horizontal
                stackView.spacing = 8
                stackView.distribution = .fillProportionally
                cell.contentInset = .init(top: .zero, left: 16, bottom: 8, right: 16)
                cell.selectionStyle = .none
            },
            initializesFromNib: false
        )
        row.rowHeight = rowHeight
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: headerTitle)
        return section
    }
}
