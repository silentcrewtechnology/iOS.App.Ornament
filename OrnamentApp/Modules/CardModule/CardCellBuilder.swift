//
//  CardCellBuilder\.swift
//  OrnamentApp
//
//  Created by user on 07.08.2024.
//

import UIKit
import Components
import DesignSystem
import ArchitectureTableView
import SnapKit

final class CardCellBuilder: NSObject, CellBuilder {
    
    // MARK: - Private properties
    
    private let chipsViewSectionHelper = ChipsViewSectionHelper()
    private var viewProperties: CardView.ViewProperties = .init()
    private var style = CardViewStyle(set: .add, size: .small, stack: .false)
    private var cardView: CardView?
    private var set: CardViewStyle.Set = .add
    private var size: CardViewStyle.Size = .small
    private var stack: CardViewStyle.Stack = .false
    
    // MARK: - Methods
    
    func createSections() -> [GenericTableViewSectionModel] {
        return [
            createCardViewSection(),
            createSetSection(),
            createSizeSection(),
            createStackSection()
        ]
    }
    
    // MARK: - Private methods
    
    private func createCardViewSection() -> GenericTableViewSectionModel {
        let row = GenericTableViewRowModel(
            with: GenericTableViewCellWrapper<CardView>.self,
            configuration: { [weak self] cell, _ in
                guard let self = self else { return }
            
                self.style.update(viewProperties: &self.viewProperties, backgroundImage: .init(named: "abb"))
                cell.containedView.update(with: self.viewProperties)
                
                cell.selectionStyle = .none
                cell.containedView.snp.remakeConstraints { make in
                    make.width.equalTo(40)
                    make.height.equalTo(40)
                    make.leading.equalToSuperview().inset(16)
                }
                
                self.cardView = cell.containedView
            },
            initializesFromNib: false
        )
        row.rowHeight = 48
        
        let section = GenericTableViewSectionModel(with: [row])
        section.makeHeader(title: Constants.componentTitle)
        
        return section
    }
    
    private func createSetSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Add", "Empty", "Visa", "Mir", "Mastercard"],
            actions: [
                { [weak self] in self?.updateCardViewStyle(set: .add) },
                { [weak self] in self?.updateCardViewStyle(set: .empty) },
                { [weak self] in self?.updateCardViewStyle(set: .visa) },
                { [weak self] in self?.updateCardViewStyle(set: .mir) },
                { [weak self] in self?.updateCardViewStyle(set: .mastercard) },
            ],
            headerTitle: Constants.componentSet
        )
    }
    
    private func createSizeSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["Small", "Medium"],
            actions: [
                { [weak self] in self?.updateCardViewStyle(size: .small) },
                { [weak self] in self?.updateCardViewStyle(size: .medium) }
            ],
            headerTitle: Constants.componentSize
        )
    }
    
    private func createStackSection() -> GenericTableViewSectionModel {
        return chipsViewSectionHelper.makeHorizontalSectionWithScroll(
            titles: ["False", "True"],
            actions: [
                { [weak self] in self?.updateCardViewStyle(stack: .false) },
                { [weak self] in
                    guard let self = self else { return }
                    
                    var stackViewProperties = CardView.ViewProperties()
                    let stackStyle = CardViewStyle(set: self.set, size: self.size, stack: .false)
                    stackStyle.update(viewProperties: &stackViewProperties, backgroundImage: .init(named: "abb"))
                    self.updateCardViewStyle(stack: .true(stackViewProperties))
                }
            ],
            headerTitle: Constants.componentStack
        )
    }
    
    private func updateCardViewStyle(
        set: CardViewStyle.Set? = nil,
        size: CardViewStyle.Size? = nil,
        stack: CardViewStyle.Stack? = nil
    ) {
        if let set {
            self.set = set

        }
        
        var backgroundImage: UIImage?
        switch self.set {
        case .visa, .mir, .mastercard:
            backgroundImage = .init(named: "abb")
        default:
            backgroundImage = nil
        }
        
        if let size {
            self.size = size
            let width = size == .medium ? 50 : 40
            
            cardView?.snp.remakeConstraints { make in
                make.width.equalTo(width)
                make.height.equalTo(40)
                make.leading.equalToSuperview().inset(16)
            }
        }
        
        if let stack {
            self.stack = stack
        }
        
        viewProperties = .init()
        style = .init(set: self.set, size: self.size, stack: self.stack)
        style.update(
            viewProperties: &viewProperties,
            backgroundImage: backgroundImage,
            maskedCardNumber: self.size == .medium ? "•• 8171".attributed : nil
        )
        cardView?.update(with: viewProperties)
    }
}
