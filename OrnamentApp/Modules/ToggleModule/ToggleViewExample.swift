//
//  ToggleViewExample.swift
//
//
//  Created by user on 13.05.2024.
//

import UIKit
import Components
import DesignSystem

private final class ToggleViewExampleVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var toggleView = ToggleView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(toggleView)
        var toggleStyle = ToggleViewStyle(state: .default)
        var viewProperties = ToggleView.ViewProperties() { isOn in
            print(isOn)
        }
        toggleStyle.update(viewProperties: &viewProperties)
        toggleView.update(with: viewProperties)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            toggleStyle.state = .disabled
            toggleStyle.update(viewProperties: &viewProperties)
            viewProperties.isChecked = true
            self.toggleView.update(with: viewProperties)
        }
    }
}
