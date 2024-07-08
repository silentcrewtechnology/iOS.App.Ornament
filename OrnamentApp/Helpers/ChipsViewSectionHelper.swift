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
    func makeHorizontalSection(
        titles: [String],
        actions: [() -> Void],
        headerTitle: String,
        rowHeight: CGFloat = 48,
        viewWidth: CGFloat = 48
    ) -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<UIStackView>.self,
            configuration: { cell, _ in
                var updaters = [ChipsViewUpdater]()
                var views = [UIView]()
                
                for i in 0..<titles.count {
                    let chipsViewProperties = ChipsView.ViewProperties(text: NSMutableAttributedString(string: titles[i]))
                    let chipsView = ChipsView()
                    cell.containedView.addArrangedSubview(chipsView)
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
                
                let view = UIView()
                cell.containedView.addArrangedSubview(view)
                views.append(view)
                views.forEach { chipsView in
                    chipsView.snp.makeConstraints { make in
                        make.width.equalTo(viewWidth)
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
        row.rowHeight = rowHeight
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: headerTitle)
        return section
    }
}
