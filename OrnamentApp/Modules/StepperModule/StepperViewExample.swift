//
//  StepperViewExample.swift
//  OrnamentApp
//
//  Created by user on 30.07.2024.
//

import UIKit
import Components
import DesignSystem

private final class StepperViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var stepperView = StepperView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        example()
    }
    
    // MARK: - Private methods
    
    private func example() {
        view.addSubview(stepperView)
        let allCount = 5
        var viewProperties = StepperView.ViewProperties(
            items: (0..<allCount).map { _ in .init() },
            height: 4)
        // 40% progress
        let activeCount40 = 2
        for index in viewProperties.items.indices {
            viewProperties.items[index] = createItemViewProperty(activeCount: activeCount40, index: index)
        }
        stepperView.update(with: viewProperties)
        // 60% progress
        let activeCount60 = 3
        for index in viewProperties.items.indices {
            viewProperties.items[index] = createItemViewProperty(activeCount: activeCount60, index: index)
        }
        stepperView.update(with: viewProperties)
    }

    private func createItemViewProperty(activeCount: Int, index: Int) -> StepperItemView.ViewProperties {
        var itemViewProperties = StepperItemView.ViewProperties()
        let style = StepperItemViewStyle()
        let state: StepperItemViewStyle.State
        
        if index < activeCount {
            state = .success
        } else if index == activeCount {
            state = .current
        } else {
            state = .next
        }
        
        style.update(state: state,
                     viewProperties: &itemViewProperties)
        return itemViewProperties
    }
}
