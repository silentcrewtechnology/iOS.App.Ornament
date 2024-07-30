//
//  TabsViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class TabsViewExampleVC: UIViewController {
    
    // MARK: - Properties
    
    var viewProperties: TabsView.ViewProperties = .init()
    let tabsView: TabsView = .init()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        example()
    }
    
    // MARK: - Private methods
    
    private func example() {
        view.addSubview(tabsView)
        let style = TabViewStyle()
        let onSelect: (Int) -> Void = { [weak self] index in
            guard let self else { return }
            guard index != self.viewProperties.selectedTabIndex else { return }
            self.viewProperties.selectedTabIndex = index
            // Необязательный сброс rightView, если тапнули по TabItem
            self.viewProperties.items[index].rightView = nil
            style.update(viewProperties: &self.viewProperties)
            self.tabsView.update(with: self.viewProperties)
        }
        let initialSelectedIndex: Int = 2
        let tabItems: [TabItemView.ViewProperties] = [
            "123".attributed,
            "456".attributed,
            "789".attributed,
            "012".attributed,
            "345".attributed
        ].enumerated().map { index, text in
            .init(text: text, onTap: { onSelect(index) })
        }
        viewProperties = .init(
            items: tabItems,
            selectedTabIndex: initialSelectedIndex)
        // Добавляем indicator
        let indicatedIndex: Int = 3
        viewProperties.items[indicatedIndex].rightView = {
            let view = IndicatorView()
            var viewProperties = IndicatorView.ViewProperties()
            let style = IndicatorViewStyle(style: .danger, size: .sizeS)
            style.update(viewProperties: &viewProperties)
            view.update(with: viewProperties)
            return view
        }()
        style.update(viewProperties: &viewProperties)
        tabsView.update(with: viewProperties)
        // ...
        // тап по элементу, ожидается сброс indicator
        onSelect(indicatedIndex)
    }
}
