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
    
    func makeHorizontalSectionWithScroll(
        titles: [String],
        actions: [() -> Void],
        headerTitle: String,
        rowHeight: CGFloat = 48
    ) -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<UIScrollView>.self,
            configuration: { cell, _ in
                var updaters = [ChipsViewUpdater]()
                var views = [UIView]()
                let stackView = UIStackView()
                cell.containedView.addSubview(stackView)
                stackView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                
                for i in 0..<titles.count {
                    let chipsViewProperties = ChipsView.ViewProperties(text: NSMutableAttributedString(string: titles[i]))
                    let chipsView = ChipsView()
                    stackView.addArrangedSubview(chipsView)
                    views.append(chipsView)
                    
                    updaters.append(
                        .init(
                            view: chipsView,
                            viewProperties: chipsViewProperties,
                            style: .init(
                                selection: i == .zero ? .selected : .default,
                                state: .default,
                                size: .small
                            ),
                            onActive: {
                                for j in 0..<updaters.count {
                                    if j == i {
                                        updaters[j].handle(state: .selection(.selected))
                                        continue
                                    }
                                    
                                    updaters[j].handle(state: .selection(.default))
                                }
                                
                                actions[i]()
                            },
                            onInactive: {}
                        )
                    )
                }
                
                stackView.axis = .horizontal
                stackView.spacing = 8
                stackView.distribution = .fillProportionally
                cell.contentInset = .init(top: .zero, left: 16, bottom: 16, right: 16)
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
